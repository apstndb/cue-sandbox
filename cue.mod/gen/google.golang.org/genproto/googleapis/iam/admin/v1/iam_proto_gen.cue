// Copyright 2021 Google LLC
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
package admin

import (
	"google.golang.org/protobuf/types/known/fieldmaskpb"
	"time"
	"google.golang.org/genproto/googleapis/type/expr"
)

// An IAM service account.
//
// A service account is an account for an application or a virtual machine (VM)
// instance, not a person. You can use a service account to call Google APIs. To
// learn more, read the [overview of service
// accounts](https://cloud.google.com/iam/help/service-accounts/overview).
//
// When you create a service account, you specify the project ID that owns the
// service account, as well as a name that must be unique within the project.
// IAM uses these values to create an email address that identifies the service
// account.
#ServiceAccount: {
	@protobuf(option (google.api.resource)=)

	// The resource name of the service account.
	//
	// Use one of the following formats:
	//
	// * `projects/{PROJECT_ID}/serviceAccounts/{EMAIL_ADDRESS}`
	// * `projects/{PROJECT_ID}/serviceAccounts/{UNIQUE_ID}`
	//
	// As an alternative, you can use the `-` wildcard character instead of the
	// project ID:
	//
	// * `projects/-/serviceAccounts/{EMAIL_ADDRESS}`
	// * `projects/-/serviceAccounts/{UNIQUE_ID}`
	//
	// When possible, avoid using the `-` wildcard character, because it can cause
	// response messages to contain misleading error codes. For example, if you
	// try to get the service account
	// `projects/-/serviceAccounts/fake@example.com`, which does not exist, the
	// response contains an HTTP `403 Forbidden` error instead of a `404 Not
	// Found` error.
	name?: string @protobuf(1,string)

	// Output only. The ID of the project that owns the service account.
	projectId?: string @protobuf(2,string,name=project_id,"(google.api.field_behavior)=OUTPUT_ONLY")

	// Output only. The unique, stable numeric ID for the service account.
	//
	// Each service account retains its unique ID even if you delete the service
	// account. For example, if you delete a service account, then create a new
	// service account with the same name, the new service account has a different
	// unique ID than the deleted service account.
	uniqueId?: string @protobuf(4,string,name=unique_id,"(google.api.field_behavior)=OUTPUT_ONLY")

	// Output only. The email address of the service account.
	email?: string @protobuf(5,string,"(google.api.field_behavior)=OUTPUT_ONLY")

	// Optional. A user-specified, human-readable name for the service account. The maximum
	// length is 100 UTF-8 bytes.
	displayName?: string @protobuf(6,string,name=display_name,"(google.api.field_behavior)=OPTIONAL")

	// Deprecated. Do not use.
	etag?: bytes @protobuf(7,bytes,deprecated)

	// Optional. A user-specified, human-readable description of the service account. The
	// maximum length is 256 UTF-8 bytes.
	description?: string @protobuf(8,string,"(google.api.field_behavior)=OPTIONAL")

	// Output only. The OAuth 2.0 client ID for the service account.
	oauth2ClientId?: string @protobuf(9,string,name=oauth2_client_id,"(google.api.field_behavior)=OUTPUT_ONLY")

	// Output only. Whether the service account is disabled.
	disabled?: bool @protobuf(11,bool,"(google.api.field_behavior)=OUTPUT_ONLY")
}

// The service account create request.
#CreateServiceAccountRequest: {
	// Required. The resource name of the project associated with the service
	// accounts, such as `projects/my-project-123`.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Required. The account id that is used to generate the service account
	// email address and a stable unique id. It is unique within a project,
	// must be 6-30 characters long, and match the regular expression
	// `[a-z]([-a-z0-9]*[a-z0-9])` to comply with RFC1035.
	accountId?: string @protobuf(2,string,name=account_id,"(google.api.field_behavior)=REQUIRED")

	// The [ServiceAccount][google.iam.admin.v1.ServiceAccount] resource to
	// create. Currently, only the following values are user assignable:
	// `display_name` and `description`.
	serviceAccount?: #ServiceAccount @protobuf(3,ServiceAccount,name=service_account)
}

// The service account list request.
#ListServiceAccountsRequest: {
	// Required. The resource name of the project associated with the service
	// accounts, such as `projects/my-project-123`.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Optional limit on the number of service accounts to include in the
	// response. Further accounts can subsequently be obtained by including the
	// [ListServiceAccountsResponse.next_page_token][google.iam.admin.v1.ListServiceAccountsResponse.next_page_token]
	// in a subsequent request.
	//
	// The default is 20, and the maximum is 100.
	pageSize?: int32 @protobuf(2,int32,name=page_size)

	// Optional pagination token returned in an earlier
	// [ListServiceAccountsResponse.next_page_token][google.iam.admin.v1.ListServiceAccountsResponse.next_page_token].
	pageToken?: string @protobuf(3,string,name=page_token)
}

// The service account list response.
#ListServiceAccountsResponse: {
	// The list of matching service accounts.
	accounts?: [...#ServiceAccount] @protobuf(1,ServiceAccount)

	// To retrieve the next page of results, set
	// [ListServiceAccountsRequest.page_token][google.iam.admin.v1.ListServiceAccountsRequest.page_token]
	// to this value.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// The service account get request.
#GetServiceAccountRequest: {
	// Required. The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// The service account delete request.
#DeleteServiceAccountRequest: {
	// Required. The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// The request for
// [PatchServiceAccount][google.iam.admin.v1.PatchServiceAccount].
//
// You can patch only the `display_name` and `description` fields. You must use
// the `update_mask` field to specify which of these fields you want to patch.
//
// Only the fields specified in the request are guaranteed to be returned in
// the response. Other fields may be empty in the response.
#PatchServiceAccountRequest: {
	serviceAccount?: #ServiceAccount        @protobuf(1,ServiceAccount,name=service_account)
	updateMask?:     fieldmaskpb.#FieldMask @protobuf(2,google.protobuf.FieldMask,name=update_mask)
}

// The service account undelete request.
#UndeleteServiceAccountRequest: {
	// The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT_UNIQUE_ID}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account.
	name?: string @protobuf(1,string)
}

#UndeleteServiceAccountResponse: {
	// Metadata for the restored service account.
	restoredAccount?: #ServiceAccount @protobuf(1,ServiceAccount,name=restored_account)
}

// The service account enable request.
#EnableServiceAccountRequest: {
	// The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string)
}

// The service account disable request.
#DisableServiceAccountRequest: {
	// The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string)
}

// The service account keys list request.
#ListServiceAccountKeysRequest: {
	// `KeyType` filters to selectively retrieve certain varieties
	// of keys.
	#KeyType:
		#KEY_TYPE_UNSPECIFIED |
		#USER_MANAGED |
		#SYSTEM_MANAGED

	// Unspecified key type. The presence of this in the
	// message will immediately result in an error.
	#KEY_TYPE_UNSPECIFIED: 0

	// User-managed keys (managed and rotated by the user).
	#USER_MANAGED: 1

	// System-managed keys (managed and rotated by Google).
	#SYSTEM_MANAGED: 2

	#KeyType_value: {
		KEY_TYPE_UNSPECIFIED: 0
		USER_MANAGED:         1
		SYSTEM_MANAGED:       2
	}

	// Required. The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	//
	// Using `-` as a wildcard for the `PROJECT_ID`, will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Filters the types of keys the user wants to include in the list
	// response. Duplicate key types are not allowed. If no key type
	// is provided, all keys are returned.
	keyTypes?: [...#KeyType] @protobuf(2,KeyType,name=key_types)
}

// The service account keys list response.
#ListServiceAccountKeysResponse: {
	// The public keys for the service account.
	keys?: [...#ServiceAccountKey] @protobuf(1,ServiceAccountKey)
}

// The service account key get by id request.
#GetServiceAccountKeyRequest: {
	// Required. The resource name of the service account key in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
	//
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The output format of the public key requested.
	// X509_PEM is the default output format.
	publicKeyType?: #ServiceAccountPublicKeyType @protobuf(2,ServiceAccountPublicKeyType,name=public_key_type)
}

// Represents a service account key.
//
// A service account has two sets of key-pairs: user-managed, and
// system-managed.
//
// User-managed key-pairs can be created and deleted by users.  Users are
// responsible for rotating these keys periodically to ensure security of
// their service accounts.  Users retain the private key of these key-pairs,
// and Google retains ONLY the public key.
//
// System-managed keys are automatically rotated by Google, and are used for
// signing for a maximum of two weeks. The rotation process is probabilistic,
// and usage of the new key will gradually ramp up and down over the key's
// lifetime.
//
// If you cache the public key set for a service account, we recommend that you
// update the cache every 15 minutes. User-managed keys can be added and removed
// at any time, so it is important to update the cache frequently. For
// Google-managed keys, Google will publish a key at least 6 hours before it is
// first used for signing and will keep publishing it for at least 6 hours after
// it was last used for signing.
//
// Public keys for all service accounts are also published at the OAuth2
// Service Account API.
#ServiceAccountKey: {
	@protobuf(option (google.api.resource)=)

	// The resource name of the service account key in the following format
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
	name?: string @protobuf(1,string)

	// The output format for the private key.
	// Only provided in `CreateServiceAccountKey` responses, not
	// in `GetServiceAccountKey` or `ListServiceAccountKey` responses.
	//
	// Google never exposes system-managed private keys, and never retains
	// user-managed private keys.
	privateKeyType?: #ServiceAccountPrivateKeyType @protobuf(2,ServiceAccountPrivateKeyType,name=private_key_type)

	// Specifies the algorithm (and possibly key size) for the key.
	keyAlgorithm?: #ServiceAccountKeyAlgorithm @protobuf(8,ServiceAccountKeyAlgorithm,name=key_algorithm)

	// The private key data. Only provided in `CreateServiceAccountKey`
	// responses. Make sure to keep the private key data secure because it
	// allows for the assertion of the service account identity.
	// When base64 decoded, the private key data can be used to authenticate with
	// Google API client libraries and with
	// <a href="/sdk/gcloud/reference/auth/activate-service-account">gcloud
	// auth activate-service-account</a>.
	privateKeyData?: bytes @protobuf(3,bytes,name=private_key_data)

	// The public key data. Only provided in `GetServiceAccountKey` responses.
	publicKeyData?: bytes @protobuf(7,bytes,name=public_key_data)

	// The key can be used after this timestamp.
	validAfterTime?: time.Time @protobuf(4,google.protobuf.Timestamp,name=valid_after_time)

	// The key can be used before this timestamp.
	// For system-managed key pairs, this timestamp is the end time for the
	// private key signing operation. The public key could still be used
	// for verification for a few hours after this time.
	validBeforeTime?: time.Time @protobuf(5,google.protobuf.Timestamp,name=valid_before_time)

	// The key origin.
	keyOrigin?: #ServiceAccountKeyOrigin @protobuf(9,ServiceAccountKeyOrigin,name=key_origin)

	// The key type.
	keyType?: #ListServiceAccountKeysRequest.#KeyType @protobuf(10,ListServiceAccountKeysRequest.KeyType,name=key_type)
}

// The service account key create request.
#CreateServiceAccountKeyRequest: {
	// Required. The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The output format of the private key. The default value is
	// `TYPE_GOOGLE_CREDENTIALS_FILE`, which is the Google Credentials File
	// format.
	privateKeyType?: #ServiceAccountPrivateKeyType @protobuf(2,ServiceAccountPrivateKeyType,name=private_key_type)

	// Which type of key and algorithm to use for the key.
	// The default is currently a 2K RSA key.  However this may change in the
	// future.
	keyAlgorithm?: #ServiceAccountKeyAlgorithm @protobuf(3,ServiceAccountKeyAlgorithm,name=key_algorithm)
}

// The service account key upload request.
#UploadServiceAccountKeyRequest: {
	// The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string)

	// A field that allows clients to upload their own public key. If set,
	// use this public key data to create a service account key for given
	// service account.
	// Please note, the expected format for this field is X509_PEM.
	publicKeyData?: bytes @protobuf(2,bytes,name=public_key_data)
}

// The service account key delete request.
#DeleteServiceAccountKeyRequest: {
	// Required. The resource name of the service account key in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Deprecated. [Migrate to Service Account Credentials
// API](https://cloud.google.com/iam/help/credentials/migrate-api).
//
// The service account sign blob request.
#SignBlobRequest: {
	// Required. Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,deprecated,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Required. Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The bytes to sign.
	bytesToSign?: bytes @protobuf(2,bytes,name=bytes_to_sign,deprecated,"(google.api.field_behavior)=REQUIRED")
}

// Deprecated. [Migrate to Service Account Credentials
// API](https://cloud.google.com/iam/help/credentials/migrate-api).
//
// The service account sign blob response.
#SignBlobResponse: {
	// Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The id of the key used to sign the blob.
	keyId?: string @protobuf(1,string,name=key_id,deprecated)

	// Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The signed blob.
	signature?: bytes @protobuf(2,bytes,deprecated)
}

// Supported key algorithms.
#ServiceAccountKeyAlgorithm:
	#KEY_ALG_UNSPECIFIED |
	#KEY_ALG_RSA_1024 |
	#KEY_ALG_RSA_2048

// An unspecified key algorithm.
#KEY_ALG_UNSPECIFIED: 0

// 1k RSA Key.
#KEY_ALG_RSA_1024: 1

// 2k RSA Key.
#KEY_ALG_RSA_2048: 2

#ServiceAccountKeyAlgorithm_value: {
	KEY_ALG_UNSPECIFIED: 0
	KEY_ALG_RSA_1024:    1
	KEY_ALG_RSA_2048:    2
}

// Supported private key output formats.
#ServiceAccountPrivateKeyType:
	#TYPE_UNSPECIFIED |
	#TYPE_PKCS12_FILE |
	#TYPE_GOOGLE_CREDENTIALS_FILE

// Unspecified. Equivalent to `TYPE_GOOGLE_CREDENTIALS_FILE`.
#TYPE_UNSPECIFIED: 0

// PKCS12 format.
// The password for the PKCS12 file is `notasecret`.
// For more information, see https://tools.ietf.org/html/rfc7292.
#TYPE_PKCS12_FILE: 1

// Google Credentials File format.
#TYPE_GOOGLE_CREDENTIALS_FILE: 2

#ServiceAccountPrivateKeyType_value: {
	TYPE_UNSPECIFIED:             0
	TYPE_PKCS12_FILE:             1
	TYPE_GOOGLE_CREDENTIALS_FILE: 2
}

// Supported public key output formats.
#ServiceAccountPublicKeyType:
	#TYPE_NONE |
	#TYPE_X509_PEM_FILE |
	#TYPE_RAW_PUBLIC_KEY

// Unspecified. Returns nothing here.
#TYPE_NONE: 0

// X509 PEM format.
#TYPE_X509_PEM_FILE: 1

// Raw public key.
#TYPE_RAW_PUBLIC_KEY: 2

#ServiceAccountPublicKeyType_value: {
	TYPE_NONE:           0
	TYPE_X509_PEM_FILE:  1
	TYPE_RAW_PUBLIC_KEY: 2
}

// Service Account Key Origin.
#ServiceAccountKeyOrigin:
	#ORIGIN_UNSPECIFIED |
	#USER_PROVIDED |
	#GOOGLE_PROVIDED

// Unspecified key origin.
#ORIGIN_UNSPECIFIED: 0

// Key is provided by user.
#USER_PROVIDED: 1

// Key is provided by Google.
#GOOGLE_PROVIDED: 2

#ServiceAccountKeyOrigin_value: {
	ORIGIN_UNSPECIFIED: 0
	USER_PROVIDED:      1
	GOOGLE_PROVIDED:    2
}

// Deprecated. [Migrate to Service Account Credentials
// API](https://cloud.google.com/iam/help/credentials/migrate-api).
//
// The service account sign JWT request.
#SignJwtRequest: {
	// Required. Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The resource name of the service account in the following format:
	// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
	// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
	// the account. The `ACCOUNT` value can be the `email` address or the
	// `unique_id` of the service account.
	name?: string @protobuf(1,string,deprecated,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Required. Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The JWT payload to sign. Must be a serialized JSON object that contains a
	// JWT Claims Set. For example: `{"sub": "user@example.com", "iat": 313435}`
	//
	// If the JWT Claims Set contains an expiration time (`exp`) claim, it must be
	// an integer timestamp that is not in the past and no more than 1 hour in the
	// future.
	//
	// If the JWT Claims Set does not contain an expiration time (`exp`) claim,
	// this claim is added automatically, with a timestamp that is 1 hour in the
	// future.
	payload?: string @protobuf(2,string,deprecated,"(google.api.field_behavior)=REQUIRED")
}

// Deprecated. [Migrate to Service Account Credentials
// API](https://cloud.google.com/iam/help/credentials/migrate-api).
//
// The service account sign JWT response.
#SignJwtResponse: {
	// Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The id of the key used to sign the JWT.
	keyId?: string @protobuf(1,string,name=key_id,deprecated)

	// Deprecated. [Migrate to Service Account Credentials
	// API](https://cloud.google.com/iam/help/credentials/migrate-api).
	//
	// The signed JWT.
	signedJwt?: string @protobuf(2,string,name=signed_jwt,deprecated)
}

// A role in the Identity and Access Management API.
#Role: {
	// A stage representing a role's lifecycle phase.
	#RoleLaunchStage:
		#ALPHA |
		#BETA |
		#GA |
		#DEPRECATED |
		#DISABLED |
		#EAP

	// The user has indicated this role is currently in an Alpha phase. If this
	// launch stage is selected, the `stage` field will not be included when
	// requesting the definition for a given role.
	#ALPHA: 0

	// The user has indicated this role is currently in a Beta phase.
	#BETA: 1

	// The user has indicated this role is generally available.
	#GA: 2

	// The user has indicated this role is being deprecated.
	#DEPRECATED: 4

	// This role is disabled and will not contribute permissions to any members
	// it is granted to in policies.
	#DISABLED: 5

	// The user has indicated this role is currently in an EAP phase.
	#EAP: 6

	#RoleLaunchStage_value: {
		ALPHA:      0
		BETA:       1
		GA:         2
		DEPRECATED: 4
		DISABLED:   5
		EAP:        6
	}

	// The name of the role.
	//
	// When Role is used in CreateRole, the role name must not be set.
	//
	// When Role is used in output and other input such as UpdateRole, the role
	// name is the complete path, e.g., roles/logging.viewer for predefined roles
	// and organizations/{ORGANIZATION_ID}/roles/logging.viewer for custom roles.
	name?: string @protobuf(1,string)

	// Optional. A human-readable title for the role.  Typically this
	// is limited to 100 UTF-8 bytes.
	title?: string @protobuf(2,string)

	// Optional. A human-readable description for the role.
	description?: string @protobuf(3,string)

	// The names of the permissions this role grants when bound in an IAM policy.
	includedPermissions?: [...string] @protobuf(7,string,name=included_permissions)

	// The current launch stage of the role. If the `ALPHA` launch stage has been
	// selected for a role, the `stage` field will not be included in the
	// returned definition for the role.
	stage?: #RoleLaunchStage @protobuf(8,RoleLaunchStage)

	// Used to perform a consistent read-modify-write.
	etag?: bytes @protobuf(9,bytes)

	// The current deleted state of the role. This field is read only.
	// It will be ignored in calls to CreateRole and UpdateRole.
	deleted?: bool @protobuf(11,bool)
}

// The grantable role query request.
#QueryGrantableRolesRequest: {
	// Required. The full resource name to query from the list of grantable roles.
	//
	// The name follows the Google Cloud Platform resource format.
	// For example, a Cloud Platform project with id `my-project` will be named
	// `//cloudresourcemanager.googleapis.com/projects/my-project`.
	fullResourceName?: string    @protobuf(1,string,name=full_resource_name,"(google.api.field_behavior)=REQUIRED")
	view?:             #RoleView @protobuf(2,RoleView)

	// Optional limit on the number of roles to include in the response.
	//
	// The default is 300, and the maximum is 1,000.
	pageSize?: int32 @protobuf(3,int32,name=page_size)

	// Optional pagination token returned in an earlier
	// QueryGrantableRolesResponse.
	pageToken?: string @protobuf(4,string,name=page_token)
}

// The grantable role query response.
#QueryGrantableRolesResponse: {
	// The list of matching roles.
	roles?: [...#Role] @protobuf(1,Role)

	// To retrieve the next page of results, set
	// `QueryGrantableRolesRequest.page_token` to this value.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// The request to get all roles defined under a resource.
#ListRolesRequest: {
	// The `parent` parameter's value depends on the target resource for the
	// request, namely
	// [`roles`](/iam/reference/rest/v1/roles),
	// [`projects`](/iam/reference/rest/v1/projects.roles), or
	// [`organizations`](/iam/reference/rest/v1/organizations.roles). Each
	// resource type's `parent` value format is described below:
	//
	// * [`roles.list()`](/iam/reference/rest/v1/roles/list): An empty string.
	//   This method doesn't require a resource; it simply returns all
	//   [predefined roles](/iam/docs/understanding-roles#predefined_roles) in
	//   Cloud IAM. Example request URL:
	//   `https://iam.googleapis.com/v1/roles`
	//
	// * [`projects.roles.list()`](/iam/reference/rest/v1/projects.roles/list):
	//   `projects/{PROJECT_ID}`. This method lists all project-level
	//   [custom roles](/iam/docs/understanding-custom-roles).
	//   Example request URL:
	//   `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles`
	//
	// * [`organizations.roles.list()`](/iam/reference/rest/v1/organizations.roles/list):
	//   `organizations/{ORGANIZATION_ID}`. This method lists all
	//   organization-level [custom roles](/iam/docs/understanding-custom-roles).
	//   Example request URL:
	//   `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles`
	//
	// Note: Wildcard (*) values are invalid; you must specify a complete project
	// ID or organization ID.
	parent?: string @protobuf(1,string,#"(google.api.resource_reference).type="*""#)

	// Optional limit on the number of roles to include in the response.
	//
	// The default is 300, and the maximum is 1,000.
	pageSize?: int32 @protobuf(2,int32,name=page_size)

	// Optional pagination token returned in an earlier ListRolesResponse.
	pageToken?: string @protobuf(3,string,name=page_token)

	// Optional view for the returned Role objects. When `FULL` is specified,
	// the `includedPermissions` field is returned, which includes a list of all
	// permissions in the role. The default value is `BASIC`, which does not
	// return the `includedPermissions` field.
	view?: #RoleView @protobuf(4,RoleView)

	// Include Roles that have been deleted.
	showDeleted?: bool @protobuf(6,bool,name=show_deleted)
}

// The response containing the roles defined under a resource.
#ListRolesResponse: {
	// The Roles defined on this resource.
	roles?: [...#Role] @protobuf(1,Role)

	// To retrieve the next page of results, set
	// `ListRolesRequest.page_token` to this value.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// The request to get the definition of an existing role.
#GetRoleRequest: {
	// The `name` parameter's value depends on the target resource for the
	// request, namely
	// [`roles`](/iam/reference/rest/v1/roles),
	// [`projects`](/iam/reference/rest/v1/projects.roles), or
	// [`organizations`](/iam/reference/rest/v1/organizations.roles). Each
	// resource type's `name` value format is described below:
	//
	// * [`roles.get()`](/iam/reference/rest/v1/roles/get): `roles/{ROLE_NAME}`.
	//   This method returns results from all
	//   [predefined roles](/iam/docs/understanding-roles#predefined_roles) in
	//   Cloud IAM. Example request URL:
	//   `https://iam.googleapis.com/v1/roles/{ROLE_NAME}`
	//
	// * [`projects.roles.get()`](/iam/reference/rest/v1/projects.roles/get):
	//   `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method returns only
	//   [custom roles](/iam/docs/understanding-custom-roles) that have been
	//   created at the project level. Example request URL:
	//   `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// * [`organizations.roles.get()`](/iam/reference/rest/v1/organizations.roles/get):
	//   `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
	//   returns only [custom roles](/iam/docs/understanding-custom-roles) that
	//   have been created at the organization level. Example request URL:
	//   `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// Note: Wildcard (*) values are invalid; you must specify a complete project
	// ID or organization ID.
	name?: string @protobuf(1,string,#"(google.api.resource_reference).type="*""#)
}

// The request to create a new role.
#CreateRoleRequest: {
	// The `parent` parameter's value depends on the target resource for the
	// request, namely
	// [`projects`](/iam/reference/rest/v1/projects.roles) or
	// [`organizations`](/iam/reference/rest/v1/organizations.roles). Each
	// resource type's `parent` value format is described below:
	//
	// * [`projects.roles.create()`](/iam/reference/rest/v1/projects.roles/create):
	//   `projects/{PROJECT_ID}`. This method creates project-level
	//   [custom roles](/iam/docs/understanding-custom-roles).
	//   Example request URL:
	//   `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles`
	//
	// * [`organizations.roles.create()`](/iam/reference/rest/v1/organizations.roles/create):
	//   `organizations/{ORGANIZATION_ID}`. This method creates organization-level
	//   [custom roles](/iam/docs/understanding-custom-roles). Example request
	//   URL:
	//   `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles`
	//
	// Note: Wildcard (*) values are invalid; you must specify a complete project
	// ID or organization ID.
	parent?: string @protobuf(1,string,#"(google.api.resource_reference).type="*""#)

	// The role ID to use for this role.
	//
	// A role ID may contain alphanumeric characters, underscores (`_`), and
	// periods (`.`). It must contain a minimum of 3 characters and a maximum of
	// 64 characters.
	roleId?: string @protobuf(2,string,name=role_id)

	// The Role resource to create.
	role?: #Role @protobuf(3,Role)
}

// The request to update a role.
#UpdateRoleRequest: {
	// The `name` parameter's value depends on the target resource for the
	// request, namely
	// [`projects`](/iam/reference/rest/v1/projects.roles) or
	// [`organizations`](/iam/reference/rest/v1/organizations.roles). Each
	// resource type's `name` value format is described below:
	//
	// * [`projects.roles.patch()`](/iam/reference/rest/v1/projects.roles/patch):
	//   `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method updates only
	//   [custom roles](/iam/docs/understanding-custom-roles) that have been
	//   created at the project level. Example request URL:
	//   `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// * [`organizations.roles.patch()`](/iam/reference/rest/v1/organizations.roles/patch):
	//   `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
	//   updates only [custom roles](/iam/docs/understanding-custom-roles) that
	//   have been created at the organization level. Example request URL:
	//   `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// Note: Wildcard (*) values are invalid; you must specify a complete project
	// ID or organization ID.
	name?: string @protobuf(1,string,#"(google.api.resource_reference).type="*""#)

	// The updated role.
	role?: #Role @protobuf(2,Role)

	// A mask describing which fields in the Role have changed.
	updateMask?: fieldmaskpb.#FieldMask @protobuf(3,google.protobuf.FieldMask,name=update_mask)
}

// The request to delete an existing role.
#DeleteRoleRequest: {
	// The `name` parameter's value depends on the target resource for the
	// request, namely
	// [`projects`](/iam/reference/rest/v1/projects.roles) or
	// [`organizations`](/iam/reference/rest/v1/organizations.roles). Each
	// resource type's `name` value format is described below:
	//
	// * [`projects.roles.delete()`](/iam/reference/rest/v1/projects.roles/delete):
	//   `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method deletes only
	//   [custom roles](/iam/docs/understanding-custom-roles) that have been
	//   created at the project level. Example request URL:
	//   `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// * [`organizations.roles.delete()`](/iam/reference/rest/v1/organizations.roles/delete):
	//   `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
	//   deletes only [custom roles](/iam/docs/understanding-custom-roles) that
	//   have been created at the organization level. Example request URL:
	//   `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// Note: Wildcard (*) values are invalid; you must specify a complete project
	// ID or organization ID.
	name?: string @protobuf(1,string,#"(google.api.resource_reference).type="*""#)

	// Used to perform a consistent read-modify-write.
	etag?: bytes @protobuf(2,bytes)
}

// The request to undelete an existing role.
#UndeleteRoleRequest: {
	// The `name` parameter's value depends on the target resource for the
	// request, namely
	// [`projects`](/iam/reference/rest/v1/projects.roles) or
	// [`organizations`](/iam/reference/rest/v1/organizations.roles). Each
	// resource type's `name` value format is described below:
	//
	// * [`projects.roles.undelete()`](/iam/reference/rest/v1/projects.roles/undelete):
	//   `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method undeletes
	//   only [custom roles](/iam/docs/understanding-custom-roles) that have been
	//   created at the project level. Example request URL:
	//   `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// * [`organizations.roles.undelete()`](/iam/reference/rest/v1/organizations.roles/undelete):
	//   `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
	//   undeletes only [custom roles](/iam/docs/understanding-custom-roles) that
	//   have been created at the organization level. Example request URL:
	//   `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
	//
	// Note: Wildcard (*) values are invalid; you must specify a complete project
	// ID or organization ID.
	name?: string @protobuf(1,string,#"(google.api.resource_reference).type="*""#)

	// Used to perform a consistent read-modify-write.
	etag?: bytes @protobuf(2,bytes)
}

// A permission which can be included by a role.
#Permission: {
	// A stage representing a permission's lifecycle phase.
	#PermissionLaunchStage:
		#ALPHA |
		#BETA |
		#GA |
		#DEPRECATED

	// The permission is currently in an alpha phase.
	#ALPHA: 0

	// The permission is currently in a beta phase.
	#BETA: 1

	// The permission is generally available.
	#GA: 2

	// The permission is being deprecated.
	#DEPRECATED: 3

	#PermissionLaunchStage_value: {
		ALPHA:      0
		BETA:       1
		GA:         2
		DEPRECATED: 3
	}

	// The state of the permission with regards to custom roles.
	#CustomRolesSupportLevel:
		#SUPPORTED |
		#TESTING |
		#NOT_SUPPORTED

	// Permission is fully supported for custom role use.
	#SUPPORTED: 0

	// Permission is being tested to check custom role compatibility.
	#TESTING: 1

	// Permission is not supported for custom role use.
	#NOT_SUPPORTED: 2

	#CustomRolesSupportLevel_value: {
		SUPPORTED:     0
		TESTING:       1
		NOT_SUPPORTED: 2
	}

	// The name of this Permission.
	name?: string @protobuf(1,string)

	// The title of this Permission.
	title?: string @protobuf(2,string)

	// A brief description of what this Permission is used for.
	// This permission can ONLY be used in predefined roles.
	description?:           string @protobuf(3,string)
	onlyInPredefinedRoles?: bool   @protobuf(4,bool,name=only_in_predefined_roles,deprecated)

	// The current launch stage of the permission.
	stage?: #PermissionLaunchStage @protobuf(5,PermissionLaunchStage)

	// The current custom role support level.
	customRolesSupportLevel?: #CustomRolesSupportLevel @protobuf(6,CustomRolesSupportLevel,name=custom_roles_support_level)

	// The service API associated with the permission is not enabled.
	apiDisabled?: bool @protobuf(7,bool,name=api_disabled)

	// The preferred name for this permission. If present, then this permission is
	// an alias of, and equivalent to, the listed primary_permission.
	primaryPermission?: string @protobuf(8,string,name=primary_permission)
}

// A request to get permissions which can be tested on a resource.
#QueryTestablePermissionsRequest: {
	// Required. The full resource name to query from the list of testable
	// permissions.
	//
	// The name follows the Google Cloud Platform resource format.
	// For example, a Cloud Platform project with id `my-project` will be named
	// `//cloudresourcemanager.googleapis.com/projects/my-project`.
	fullResourceName?: string @protobuf(1,string,name=full_resource_name)

	// Optional limit on the number of permissions to include in the response.
	//
	// The default is 100, and the maximum is 1,000.
	pageSize?: int32 @protobuf(2,int32,name=page_size)

	// Optional pagination token returned in an earlier
	// QueryTestablePermissionsRequest.
	pageToken?: string @protobuf(3,string,name=page_token)
}

// The response containing permissions which can be tested on a resource.
#QueryTestablePermissionsResponse: {
	// The Permissions testable on the requested resource.
	permissions?: [...#Permission] @protobuf(1,Permission)

	// To retrieve the next page of results, set
	// `QueryTestableRolesRequest.page_token` to this value.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// A request to get the list of auditable services for a resource.
#QueryAuditableServicesRequest: {
	// Required. The full resource name to query from the list of auditable
	// services.
	//
	// The name follows the Google Cloud Platform resource format.
	// For example, a Cloud Platform project with id `my-project` will be named
	// `//cloudresourcemanager.googleapis.com/projects/my-project`.
	fullResourceName?: string @protobuf(1,string,name=full_resource_name)
}

// A response containing a list of auditable services for a resource.
#QueryAuditableServicesResponse: {
	// Contains information about an auditable service.
	#AuditableService: {
		// Public name of the service.
		// For example, the service name for Cloud IAM is 'iam.googleapis.com'.
		name?: string @protobuf(1,string)
	}

	// The auditable services for a resource.
	services?: [...#AuditableService] @protobuf(1,AuditableService)
}

// The request to lint a Cloud IAM policy object.
#LintPolicyRequest: {
	// The full resource name of the policy this lint request is about.
	//
	// The name follows the Google Cloud Platform (GCP) resource format.
	// For example, a GCP project with ID `my-project` will be named
	// `//cloudresourcemanager.googleapis.com/projects/my-project`.
	//
	// The resource name is not used to read the policy instance from the Cloud
	// IAM database. The candidate policy for lint has to be provided in the same
	// request object.
	fullResourceName?: string @protobuf(1,string,name=full_resource_name)
	// Required. The Cloud IAM object to be linted.
	{} | {
		// [google.iam.v1.Binding.condition] [google.iam.v1.Binding.condition] object to be linted.
		condition: expr.#Expr @protobuf(5,google.type.Expr)
	}
}

// Structured response of a single validation unit.
#LintResult: {
	// Possible Level values of a validation unit corresponding to its domain
	// of discourse.
	#Level:
		#LEVEL_UNSPECIFIED |
		#CONDITION

	// Level is unspecified.
	#LEVEL_UNSPECIFIED: 0

	// A validation unit which operates on an individual condition within a
	// binding.
	#CONDITION: 3

	#Level_value: {
		LEVEL_UNSPECIFIED: 0
		CONDITION:         3
	}

	// Possible Severity values of an issued result.
	#Severity:
		#SEVERITY_UNSPECIFIED |
		#ERROR |
		#WARNING |
		#NOTICE |
		#INFO |
		#DEPRECATED

	// Severity is unspecified.
	#SEVERITY_UNSPECIFIED: 0

	// A validation unit returns an error only for critical issues. If an
	// attempt is made to set the problematic policy without rectifying the
	// critical issue, it causes the `setPolicy` operation to fail.
	#ERROR: 1

	// Any issue which is severe enough but does not cause an error.
	// For example, suspicious constructs in the input object will not
	// necessarily fail `setPolicy`, but there is a high likelihood that they
	// won't behave as expected during policy evaluation in `checkPolicy`.
	// This includes the following common scenarios:
	//
	// - Unsatisfiable condition: Expired timestamp in date/time condition.
	// - Ineffective condition: Condition on a <member, role> pair which is
	//   granted unconditionally in another binding of the same policy.
	#WARNING: 2

	// Reserved for the issues that are not severe as `ERROR`/`WARNING`, but
	// need special handling. For instance, messages about skipped validation
	// units are issued as `NOTICE`.
	#NOTICE: 3

	// Any informative statement which is not severe enough to raise
	// `ERROR`/`WARNING`/`NOTICE`, like auto-correction recommendations on the
	// input content. Note that current version of the linter does not utilize
	// `INFO`.
	#INFO: 4

	// Deprecated severity level.
	#DEPRECATED: 5

	#Severity_value: {
		SEVERITY_UNSPECIFIED: 0
		ERROR:                1
		WARNING:              2
		NOTICE:               3
		INFO:                 4
		DEPRECATED:           5
	}

	// The validation unit level.
	level?: #Level @protobuf(1,Level)

	// The validation unit name, for instance
	// "lintValidationUnits/ConditionComplexityCheck".
	validationUnitName?: string @protobuf(2,string,name=validation_unit_name)

	// The validation unit severity.
	severity?: #Severity @protobuf(3,Severity)

	// The name of the field for which this lint result is about.
	//
	// For nested messages `field_name` consists of names of the embedded fields
	// separated by period character. The top-level qualifier is the input object
	// to lint in the request. For example, the `field_name` value
	// `condition.expression` identifies a lint result for the `expression` field
	// of the provided condition.
	fieldName?: string @protobuf(5,string,name=field_name)

	// 0-based character position of problematic construct within the object
	// identified by `field_name`. Currently, this is populated only for condition
	// expression.
	locationOffset?: int32 @protobuf(6,int32,name=location_offset)

	// Human readable debug message associated with the issue.
	debugMessage?: string @protobuf(7,string,name=debug_message)
}

// The response of a lint operation. An empty response indicates
// the operation was able to fully execute and no lint issue was found.
#LintPolicyResponse: {
	// List of lint results sorted by `severity` in descending order.
	lintResults?: [...#LintResult] @protobuf(1,LintResult,name=lint_results)
}

// A view for Role objects.
#RoleView:
	#BASIC |
	#FULL

// Omits the `included_permissions` field.
// This is the default value.
#BASIC: 0

// Returns all fields.
#FULL: 1

#RoleView_value: {
	BASIC: 0
	FULL:  1
}
