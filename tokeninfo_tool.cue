package main

import (
	"github.com/apstndb/cue-sandbox/gcpauth"
	"github.com/apstndb/cue-sandbox/httpplus"
	"tool/cli"
	"tool/file"
	"tool/exec"
	"tool/http"
	"encoding/json"
	"strings"
	"strconv"
	"github.com/apstndb/cue-sandbox/jwt"
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

command: sign: {
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

	task: sign: jwt.SignJwt & {
		claims: {
			iat:   task.unix_now.output
			exp:   task.unix_now.output + 3600
			iss:   task.read_gsa.output.client_email
			sub:   task.read_gsa.output.client_email
			scope: "https://www.googleapis.com/auth/iam"
		}
		privateKeyPem: task.read_gsa.output.private_key
	}

	task: access_token: httpplus.Post & {
		url:          "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/\(#gsa_email):generateAccessToken"
		bearer_token: task.sign.output
		request_body: {
			scope: [
				"https://www.googleapis.com/auth/cloud-platform",
				"https://www.googleapis.com/auth/userinfo.email",
			]
		}
	}

	// task: compute_access_token: #ComputeMetadata & {
	//  suffix: "instance/service-accounts/default/token"
	// }

	task: tokeninfo: httpplus.Get & {
		url:          "https://oauth2.googleapis.com/tokeninfo"
		bearer_token: task.access_token.response_body.accessToken
	}

	task: display: cli.Print & {
		text: (#PrettyJSON & {input: task.tokeninfo.response_body}).output
	}
}

command: adc: {
	task: access_token: gcpauth.GcloudAccessToken

	task: tokeninfo: httpplus.Get & {
		url:          "https://oauth2.googleapis.com/tokeninfo"
		bearer_token: task.access_token.token
	}

	task: display: cli.Print & {
		text: task.tokeninfo.response.body
	}
}

command: printtoken: {
	task: access_token: gcpauth.GcloudAccessToken
	task: display:      cli.Print & {
		text: task.access_token.token
	}
}
