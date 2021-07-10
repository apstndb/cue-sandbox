package main

import (
	"tool/cli"
	"tool/file"
	"tool/exec"
	"tool/http"
	"encoding/json"
	"strings"
	"strconv"
	"github.com/apstndb/cue-sandbox/jwt"
	"github.com/apstndb/cue-sandbox/httpplus"
)

#PrettyJSON: {
	input: {...}
	output: json.Indent(json.Marshal(input), "", "  ")
}

#ComputeMetadata: http.Get & {
	suffix: string
	url:    "http://169.254.169.254/computeMetadata/v1/\(suffix)"
	request: header: "metadata-flavor": "Google"
}

command: jwt_bearer_flow: {
	task: read_gsa: file.Read & {
		// Limitation: CUE doesn't support environment variables so you should inject by -t GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}
		filename: string @tag(GOOGLE_APPLICATION_CREDENTIALS)
		contents: string
		output:   json.Unmarshal(contents)
	}

	// It is workaround because CUE doesn't support time conversion.
	task: unix_now: exec.Run & {
		cmd: ["date", "+%s"]
		stdout: string
		output: strconv.ParseInt(strings.TrimSpace(stdout), 10, 64)
	}

	task: jwt_for_id_token: jwt.SignJwt & {
		claims: {
			iat:             task.unix_now.output
			exp:             task.unix_now.output + 3600
			iss:             task.read_gsa.output.client_email
			aud:             "https://oauth2.googleapis.com/token"
			target_audience: "https://example.com"
		}
		privateKeyPem: task.read_gsa.output.private_key
	}

	task: jwt_for_access_token: jwt.SignJwt & {
		claims: {
			iat:   task.unix_now.output
			exp:   task.unix_now.output + 3600
			iss:   task.read_gsa.output.client_email
			scope: "https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/userinfo.email"
			aud:   "https://oauth2.googleapis.com/token"
		}
		privateKeyPem: task.read_gsa.output.private_key
	}

	// Google token endpoint can process application/json request
	task: jwt_bearer_flow: httpplus.Post & {
		url: "https://oauth2.googleapis.com/token"
		request_body: {
			"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer"
			"assertion":  task.jwt_for_access_token.output
			// "assertion":  task.jwt_for_id_token.output
		}
		response: body: string
	}

	task: display_jwt_bearer_flow: cli.Print & {
		text: task.jwt_bearer_flow.response.body
	}
}
