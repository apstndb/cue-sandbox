package gcpauth

#ServiceAccount: {
	type: "service_account"

	client_email:   string
	private_key_id: string
	private_key:    string
	auth_uri:       string
	token_uri:      string
	project_id:     string

	client_id:                   string
	auth_provider_x509_cert_url: string
	client_x509_cert_url:        string
}

#UserCredentials: {
	type: "authorized_user"

	client_secret: string
	client_id:     string
	refresh_token: string
}

// CredentialSource stores the information necessary to retrieve the credentials for the STS exchange.
// Either the File or the URL field should be filled, depending on the kind of credential in question.
// The EnvironmentID should start with AWS if being used for an AWS credential.
#CredentialSource: {
	file: string
	url:  string
	headers: [string]: string
	environment_id:                 string
	region_url:                     string
	regional_cred_verification_url: string
	cred_verification_url:          string
	format: {
		// Type is either "text" or "json".  When not provided "text" type is assumed.
		type: *"text" | "json"
		// SubjectTokenFieldName is only required for JSON format.  This would be "access_token" for azure.
		subject_token_field_name: string
	}
}

// See golang.org/x/oauth2/google/internal/externalaccount/basecredentials.go
#ExternalAccount: {
	type: "external_account"

	// Audience is the Secure Token Service (STS) audience which contains the resource name for the workload
	// identity pool or the workforce pool and the provider identifier in that pool.
	audience: string
	// SubjectTokenType is the STS token type based on the Oauth2.0 token exchange spec
	// e.g. `urn:ietf:params:oauth:token-type:jwt`.
	subject_token_type: string
	// TokenURL is the STS token exchange endpoint.
	token_url: string
	// TokenInfoURL is the token_info endpoint used to retrieve the account related information (
	// user attributes like account identifier, eg. email, username, uid, etc). This is
	// needed for gCloud session account identification.
	token_info_url: string
	// ServiceAccountImpersonationURL is the URL for the service account impersonation request. This is only
	// required for workload identity pools when APIs to be accessed have not integrated with UberMint.
	service_account_impersonation_url: string
	// ClientSecret is currently only required if token_info endpoint also
	// needs to be called with the generated GCP access token. When provided, STS will be
	// called with additional basic authentication using client_id as username and client_secret as password.
	client_secret: string
	// ClientID is only required in conjunction with ClientSecret, as described above.
	client_id: string
	// CredentialSource contains the necessary information to retrieve the token itself, as well
	// as some environmental information.
	credential_source: #CredentialSource
	// QuotaProjectID is injected by gCloud. If the value is non-empty, the Auth libraries
	// will set the x-goog-user-project which overrides the project associated with the credentials.
	quota_project_id: string
	// Scopes contains the desired scopes for the returned access token.
	scopes: [string]
}

#ImpersonatedServiceAccount: {
	type: "impersonated_service_account"

	delegates: [string]
	quota_project_id:                  string
	service_account_impersonation_url: string
	source_credentials:                #CredentialFile
}

#CredentialFile: #ServiceAccount | #UserCredentials | #ExternalAccount | #ImpersonatedServiceAccount
