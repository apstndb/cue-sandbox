package gcpauth
import (
	"github.com/apstndb/cue-sandbox/time"
	"github.com/apstndb/cue-sandbox/jwt"
	"github.com/apstndb/cue-sandbox/httpplus"
	"strings"

)

_token_endpoint: "https://oauth2.googleapis.com/token"

ServiceAccountTokenSource: {
	// input
		service_account: #ServiceAccount
		scopes: [...string]
		audience?: string

			task: unix_now:             time.UnixNow
			task: jwt_for_access_token: jwt.SimpleJwt & {
				_unix_now: task.unix_now.output
				claims: {
					iat:   _unix_now
					exp:   _unix_now + 3600
					iss:   service_account.client_email
					scope: strings.Join(scopes, " ")
					aud:   _token_endpoint
				}
				privateKeyPem: service_account.private_key
			}
			task: jwt_bearer_flow: httpplus.Post & {
				url: _token_endpoint
				request_body: {
					"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer"
					"assertion":  task.jwt_for_access_token.stdout
				}
			}
			response_body: task.jwt_bearer_flow.response_body

			if audience != _|_ {
				task: jwt_for_id_token: jwt.SimpleJwt & {
					$after: [task.unix_now]
					_unix_now: task.unix_now.output
					claims: {
						iat:             _unix_now
						exp:             _unix_now + 3600
						iss:             service_account.client_email
						aud:             _token_endpoint
						target_audience: audience
					}
					privateKeyPem: service_account.private_key
				}
				task: jwt_bearer_flow_for_id_token: httpplus.Post & {
					url: _token_endpoint
					request_body: {
						grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer"
						assertion:  task.jwt_for_id_token.stdout
					}
				}
				response_body: id_token: task.jwt_bearer_flow_for_id_token.response_body.id_token
			}
}