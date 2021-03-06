package main

import (
	"google.golang.org/genproto/googleapis/iam/credentials/v1:credentials"
	"github.com/apstndb/cue-sandbox/httpplus"
	"github.com/apstndb/cue-sandbox/gcpauth"
	"github.com/apstndb/cue-sandbox/gcpmetadata"
	"tool/cli"
	"tool/os"
	"list"
	"tool/file"
	"encoding/json"
)

_token_endpoint: "https://oauth2.googleapis.com/token"
_default_scopes: [
	"https://www.googleapis.com/auth/cloud-platform",
	"https://www.googleapis.com/auth/userinfo.email",
]

#Token: {
	access_token: string
	id_token?:    string
	scope?:       string
	token_type:   "Bearer"
	expires_in:   int
}

command: adc: {
	task: env: os.Getenv & {
		GOOGLE_APPLICATION_CREDENTIALS:            string
		CLOUDSDK_CONFIG:                           string
		HOME:                                      string
		CLOUDSDK_AUTH_IMPERSONATE_SERVICE_ACCOUNT: string
		AUDIENCE:                                  string
	}

	task: find_well_known_file: file.Glob & {
		let WellKnownPath = [
			if task.env.CLOUDSDK_CONFIG != _|_ {task.env.CLOUDSDK_CONFIG},
			task.env.HOME + "/.config/gcloud",
		][0] + "/application_default_credentials.json"
		glob: WellKnownPath
	}

	task: read_file: file.Read & {
		$after: [task.find_well_known_file]
		let FoundCredentialPath = list.FlattenN([
			if task.env.GOOGLE_APPLICATION_CREDENTIALS != _|_ {task.env.GOOGLE_APPLICATION_CREDENTIALS},
			task.find_well_known_file.files,
			"/dev/null",
		], 1)[0]
		filename: FoundCredentialPath
		contents: string
	}

	task: access_token: {
		$after: [task.env]
		// let Env = task.env
		let parsed = json.Unmarshal(task.read_file.contents)
		if (parsed & gcpauth.#UserCredentials) != _|_ {
			httpplus.Post & {
				let UserCredentials = parsed & gcpauth.#UserCredentials
				url: _token_endpoint
				request_body: {
					grant_type:    "refresh_token"
					client_id:     UserCredentials.client_id
					client_secret: UserCredentials.client_secret
					refresh_token: UserCredentials.refresh_token
				}
			}
		}

		if (parsed & gcpauth.#ServiceAccount) != _|_ {
			gcpauth.ServiceAccountTokenSource & {
				service_account: parsed & gcpauth.#ServiceAccount
				scopes:          _default_scopes
				audience:        task.env.AUDIENCE
			}
		}
		if task.read_file.contents == "" {
			access_token: httpplus.Get & gcpmetadata.Metadata & {
				metadata: "instance/service-accounts/default/token"
			}
			// id_token: gcpmetadata.Metadata & {
			//  if task.env.AUDIENCE != _|_ {
			//   metadata: "instance/service-accounts/default/identity?audience=\(task.env.AUDIENCE)"
			//  }
			//  if task.env.AUDIENCE == _|_ {
			//   metadata: "instance/service-accounts/default/identity"
			//  }
			// }
			response_body: access_token.response_body
		}
	}

	task: optional_impersonate: {
		$after: [task.access_token]
		if task.env.CLOUDSDK_AUTH_IMPERSONATE_SERVICE_ACCOUNT != _|_ {
			let Name = "projects/-/serviceAccounts/\(task.env.CLOUDSDK_AUTH_IMPERSONATE_SERVICE_ACCOUNT)"
			let AccessToken = task.access_token.response_body.access_token
			access_token: httpplus.Post & {
				url:          "https://iamcredentials.googleapis.com/v1/\(Name):generateAccessToken"
				bearer_token: AccessToken
				request_body: credentials.#GenerateAccessTokenRequest & {
					scope: _default_scopes
				}
				response_body: credentials.#GenerateAccessTokenResponse
			}
			response_body: "access_token": access_token.response_body.accessToken

			if task.env.AUDIENCE != _|_ {
				id_token: httpplus.Post & {
					url:          "https://iamcredentials.googleapis.com/v1/\(Name):generateIdToken"
					bearer_token: AccessToken
					request_body: credentials.#GenerateIdTokenRequest & {
						audience:     task.env.AUDIENCE
						includeEmail: true
					}
				}
				response_body: "id_token": id_token.response_body.token
			}
		}
		if task.env.CLOUDSDK_AUTH_IMPERSONATE_SERVICE_ACCOUNT == _|_ {
			response_body: task.access_token.response_body
		}
	}

	task: print: cli.Print & {
		text: json.Marshal(task.optional_impersonate.response_body)
	}
}
