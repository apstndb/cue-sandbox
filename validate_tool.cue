package main

import (
	// "github.com/apstndb/cue-sandbox/fileplus"
	"github.com/apstndb/cue-sandbox/httpplus"
	"github.com/apstndb/cue-sandbox/time"
	"tool/cli"
	"tool/os"
	"tool/file"
	"github.com/apstndb/cue-sandbox/jwt"
	"encoding/json"
)

command: validate: {
	task: env: os.Getenv & {
		GOOGLE_APPLICATION_CREDENTIALS: string
		HOME:                           string
	}

	task: find_well_known_file: file.Glob & {
		_well_known_path: task.env.HOME + "/.config/gcloud/application_default_credentials.json"
		glob:             _well_known_path
		files: [string]
	}

	task: read_file: file.Read & {
		_well_known_path:       task.env.HOME + "/.config/gcloud/application_default_credentials.json"
		_found_credential_path: [
					if task.env.GOOGLE_APPLICATION_CREDENTIALS != _|_ {task.env.GOOGLE_APPLICATION_CREDENTIALS},
					if len(task.find_well_known_file.files) > 0 {task.find_well_known_file.files[0]},
					"/dev/null",
		][0]
		filename: _found_credential_path
		contents: string
		// parsed_contents: json.Unmarshal(contents) & #CredentialFile
	}

	task: access_token: {
		let parsed = json.Unmarshal(task.read_file.contents)
		if (parsed & #UserCredentials) != _|_ {
			httpplus.Post & {
				_user_credentials: parsed & #UserCredentials
				url:              "https://www.googleapis.com/oauth2/v4/token"
				request_body: {
					grant_type:    "refresh_token"
					client_id:     _user_credentials.client_id
					client_secret: _user_credentials.client_secret
					refresh_token: _user_credentials.refresh_token
				}
			}
		}
		if (parsed & #ServiceAccount) != _|_ {
			_service_account: parsed & #ServiceAccount
			task: unix_now:             time.UnixNow
			task: jwt_for_access_token: jwt.SimpleJwt & {
				_unix_now: task.unix_now.output
				claims: {
					iat:   _unix_now
					exp:   _unix_now + 3600
					iss:   _service_account.client_email
					scope: "https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/userinfo.email"
					aud:   "https://oauth2.googleapis.com/token"
				}
				privateKeyPem: _service_account.private_key
			}
			task: jwt_bearer_flow: httpplus.Post & {
				url: "https://oauth2.googleapis.com/token"
				request_body: {
					"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer"
					"assertion":  task.jwt_for_access_token.stdout
				}
			}
			response_body: task.jwt_bearer_flow.response_body
		}
		if task.read_file.contents == "" {
			httpplus.Get & {
				request: header: "metadata-flavor": "Google"
			}
		}
	}

	// task: find_file: file.Glob & { glob: }

	task: validate: cli.Print & {
		// text: json.Marshal(json.Unmarshal(task.read_file.contents) & #CredentialFile)
		text: json.Marshal(task.access_token.response_body)
	}
}
