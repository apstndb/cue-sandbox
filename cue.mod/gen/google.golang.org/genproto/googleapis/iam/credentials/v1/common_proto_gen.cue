// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package credentials

import "time"

#GenerateAccessTokenRequest: {
	// Required. The resource name of the service account for which the credentials
	// are requested, in the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The sequence of service accounts in a delegation chain. Each service
	// account must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on its next service account in the chain. The last service account in the
	// chain must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on the service account that is specified in the `name` field of the
	// request.
	//
	// The delegates must have the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	delegates?: [...string] @protobuf(2,string)

	// Required. Code to identify the scopes to be included in the OAuth 2.0 access token.
	// See https://developers.google.com/identity/protocols/googlescopes for more
	// information.
	// At least one value required.
	scope?: [...string] @protobuf(4,string,"(google.api.field_behavior)=REQUIRED")

	// The desired lifetime duration of the access token in seconds.
	// Must be set to a value less than or equal to 3600 (1 hour). If a value is
	// not specified, the token's lifetime will be set to a default value of one
	// hour.
	lifetime?: time.Duration @protobuf(7,google.protobuf.Duration)
}

#GenerateAccessTokenResponse: {
	// The OAuth 2.0 access token.
	accessToken?: string @protobuf(1,string,name=access_token)

	// Token expiration time.
	// The expiration time is always set.
	expireTime?: time.Time @protobuf(3,google.protobuf.Timestamp,name=expire_time)
}

#SignBlobRequest: {
	// Required. The resource name of the service account for which the credentials
	// are requested, in the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The sequence of service accounts in a delegation chain. Each service
	// account must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on its next service account in the chain. The last service account in the
	// chain must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on the service account that is specified in the `name` field of the
	// request.
	//
	// The delegates must have the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	delegates?: [...string] @protobuf(3,string)

	// Required. The bytes to sign.
	payload?: bytes @protobuf(5,bytes,"(google.api.field_behavior)=REQUIRED")
}

#SignBlobResponse: {
	// The ID of the key used to sign the blob.
	keyId?: string @protobuf(1,string,name=key_id)

	// The signed blob.
	signedBlob?: bytes @protobuf(4,bytes,name=signed_blob)
}

#SignJwtRequest: {
	// Required. The resource name of the service account for which the credentials
	// are requested, in the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The sequence of service accounts in a delegation chain. Each service
	// account must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on its next service account in the chain. The last service account in the
	// chain must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on the service account that is specified in the `name` field of the
	// request.
	//
	// The delegates must have the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	delegates?: [...string] @protobuf(3,string)

	// Required. The JWT payload to sign: a JSON object that contains a JWT Claims Set.
	payload?: string @protobuf(5,string,"(google.api.field_behavior)=REQUIRED")
}

#SignJwtResponse: {
	// The ID of the key used to sign the JWT.
	keyId?: string @protobuf(1,string,name=key_id)

	// The signed JWT.
	signedJwt?: string @protobuf(2,string,name=signed_jwt)
}

#GenerateIdTokenRequest: {
	// Required. The resource name of the service account for which the credentials
	// are requested, in the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The sequence of service accounts in a delegation chain. Each service
	// account must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on its next service account in the chain. The last service account in the
	// chain must be granted the `roles/iam.serviceAccountTokenCreator` role
	// on the service account that is specified in the `name` field of the
	// request.
	//
	// The delegates must have the following format:
	// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
	// character is required; replacing it with a project ID is invalid.
	delegates?: [...string] @protobuf(2,string)

	// Required. The audience for the token, such as the API or account that this token
	// grants access to.
	audience?: string @protobuf(3,string,"(google.api.field_behavior)=REQUIRED")

	// Include the service account email in the token. If set to `true`, the
	// token will contain `email` and `email_verified` claims.
	includeEmail?: bool @protobuf(4,bool,name=include_email)
}

#GenerateIdTokenResponse: {
	// The OpenId Connect ID token.
	token?: string @protobuf(1,string)
}
