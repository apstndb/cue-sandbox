// Security Token Service API
//
// The Security Token Service exchanges Google or third-party
// credentials for a short-lived access token to Google Cloud
// resources.
package sts

info: {
	contact: {
		name:        "Google"
		url:         "https://google.com"
		"x-twitter": "youtube"
	}
	description: "The Security Token Service exchanges Google or third-party credentials for a short-lived access token to Google Cloud resources."
	license: {
		name: "Creative Commons Attribution 3.0"
		url:  "http://creativecommons.org/licenses/by/3.0/"
	}
	termsOfService: "https://developers.google.com/terms/"
	title:          *"Security Token Service API" | string
	version:        *"v1" | string
	"x-apisguru-categories": ["analytics", "media"]
	"x-logo": url: "https://upload.wikimedia.org/wikipedia/commons/e/e1/YouTube_play_buttom_icon_%282013-2017%29.svg"
	"x-origin": [{
		format:  "google"
		url:     "https://sts.googleapis.com/$discovery/rest?version=v1"
		version: "v1"
	}]
	"x-preferred":    false
	"x-providerName": "googleapis.com"
	"x-serviceName":  "sts"
}
// Request message for ExchangeToken.
#GoogleIdentityStsV1ExchangeTokenRequest: {
	// The full resource name of the identity provider; for example:
	// `//iam.googleapis.com/projects//workloadIdentityPools//providers/`.
	// Required when exchanging an external credential for a Google
	// access token.
	audience?: string

	// Required. The grant type. Must be
	// `urn:ietf:params:oauth:grant-type:token-exchange`, which
	// indicates a token exchange.
	grantType?: string

	// A set of features that Security Token Service supports, in
	// addition to the standard OAuth 2.0 token exchange, formatted
	// as a serialized JSON object of Options.
	options?: string

	// Required. An identifier for the type of requested security
	// token. Must be
	// `urn:ietf:params:oauth:token-type:access_token`.
	requestedTokenType?: string

	// The OAuth 2.0 scopes to include on the resulting access token,
	// formatted as a list of space-delimited, case-sensitive
	// strings. Required when exchanging an external credential for a
	// Google access token.
	scope?: string

	// Required. The input token. This token is either an external
	// credential issued by a workload identity pool provider, or a
	// short-lived access token issued by Google. If the token is an
	// OIDC JWT, it must use the JWT format defined in [RFC
	// 7523](https://tools.ietf.org/html/rfc7523), and the
	// `subject_token_type` must be
	// `urn:ietf:params:oauth:token-type:jwt`. The following headers
	// are required: - `kid`: The identifier of the signing key
	// securing the JWT. - `alg`: The cryptographic algorithm
	// securing the JWT. Must be `RS256` or `ES256`. The following
	// payload fields are required. For more information, see [RFC
	// 7523, Section
	// 3](https://tools.ietf.org/html/rfc7523#section-3): - `iss`:
	// The issuer of the token. The issuer must provide a discovery
	// document at the URL `/.well-known/openid-configuration`, where
	// `` is the value of this field. The document must be formatted
	// according to section 4.2 of the [OIDC 1.0 Discovery
	// specification](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationResponse).
	// - `iat`: The issue time, in seconds, since the Unix epoch.
	// Must be in the past. - `exp`: The expiration time, in seconds,
	// since the Unix epoch. Must be less than 48 hours after `iat`.
	// Shorter expiration times are more secure. If possible, we
	// recommend setting an expiration time less than 6 hours. -
	// `sub`: The identity asserted in the JWT. - `aud`: For workload
	// identity pools, this must be a value specified in the allowed
	// audiences for the workload identity pool provider, or one of
	// the audiences allowed by default if no audiences were
	// specified. See
	// https://cloud.google.com/iam/docs/reference/rest/v1/projects.locations.workloadIdentityPools.providers#oidc
	// Example header: ``` { "alg": "RS256", "kid": "us-east-11" }
	// ``` Example payload: ``` { "iss":
	// "https://accounts.google.com", "iat": 1517963104, "exp":
	// 1517966704, "aud":
	// "//iam.googleapis.com/projects/1234567890123/locations/global/workloadIdentityPools/my-pool/providers/my-provider",
	// "sub": "113475438248934895348", "my_claims": {
	// "additional_claim": "value" } } ``` If `subject_token` is for
	// AWS, it must be a serialized `GetCallerIdentity` token. This
	// token contains the same information as a request to the AWS
	// [`GetCallerIdentity()`](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetCallerIdentity)
	// method, as well as the AWS
	// [signature](https://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html)
	// for the request information. Use Signature Version 4. Format
	// the request as URL-encoded JSON, and set the
	// `subject_token_type` parameter to
	// `urn:ietf:params:aws:token-type:aws4_request`. The following
	// parameters are required: - `url`: The URL of the AWS STS
	// endpoint for `GetCallerIdentity()`, such as
	// `https://sts.amazonaws.com?Action=GetCallerIdentity&Version=2011-06-15`.
	// Regional endpoints are also supported. - `method`: The HTTP
	// request method: `POST`. - `headers`: The HTTP request headers,
	// which must include: - `Authorization`: The request signature.
	// - `x-amz-date`: The time you will send the request, formatted
	// as an [ISO8601
	// Basic](https://docs.aws.amazon.com/general/latest/gr/sigv4_elements.html#sigv4_elements_date)
	// string. This value is typically set to the current time and is
	// used to help prevent replay attacks. - `host`: The hostname of
	// the `url` field; for example, `sts.amazonaws.com`. -
	// `x-goog-cloud-target-resource`: The full, canonical resource
	// name of the workload identity pool provider, with or without
	// an `https:` prefix. To help ensure data integrity, we
	// recommend including this header in the `SignedHeaders` field
	// of the signed request. For example:
	// //iam.googleapis.com/projects//locations//workloadIdentityPools//providers/
	// https://iam.googleapis.com/projects//locations//workloadIdentityPools//providers/
	// If you are using temporary security credentials provided by
	// AWS, you must also include the header `x-amz-security-token`,
	// with the value set to the session token. The following example
	// shows a `GetCallerIdentity` token: ``` { "headers": [ {"key":
	// "x-amz-date", "value": "20200815T015049Z"}, {"key":
	// "Authorization", "value":
	// "AWS4-HMAC-SHA256+Credential=$credential,+SignedHeaders=host;x-amz-date;x-goog-cloud-target-resource,+Signature=$signature"},
	// {"key": "x-goog-cloud-target-resource", "value":
	// "//iam.googleapis.com/projects//locations//workloadIdentityPools//providers/"},
	// {"key": "host", "value": "sts.amazonaws.com"} . ], "method":
	// "POST", "url":
	// "https://sts.amazonaws.com?Action=GetCallerIdentity&Version=2011-06-15"
	// } ``` You can also use a Google-issued OAuth 2.0 access token
	// with this field to obtain an access token with new security
	// attributes applied, such as a Credential Access Boundary. In
	// this case, set `subject_token_type` to
	// `urn:ietf:params:oauth:token-type:access_token`. If an access
	// token already contains security attributes, you cannot apply
	// additional security attributes.
	subjectToken?: string

	// Required. An identifier that indicates the type of the security
	// token in the `subject_token` parameter. Supported values are
	// `urn:ietf:params:oauth:token-type:jwt`,
	// `urn:ietf:params:aws:token-type:aws4_request`, and
	// `urn:ietf:params:oauth:token-type:access_token`.
	subjectTokenType?: string
	...
}

// Response message for ExchangeToken.
#GoogleIdentityStsV1ExchangeTokenResponse: {
	// An OAuth 2.0 security token, issued by Google, in response to
	// the token exchange request. Tokens can vary in size, depending
	// in part on the size of mapped claims, up to a maximum of 12288
	// bytes (12 KB). Google reserves the right to change the token
	// size and the maximum length at any time.
	access_token?: string

	// The amount of time, in seconds, between the time when the
	// access token was issued and the time when the access token
	// will expire. This field is absent when the `subject_token` in
	// the request is a Google-issued, short-lived access token. In
	// this case, the access token has the same expiration time as
	// the `subject_token`.
	expires_in?: int

	// The token type. Always matches the value of
	// `requested_token_type` from the request.
	issued_token_type?: string

	// The type of access token. Always has the value `Bearer`.
	token_type?: string
	...
}
