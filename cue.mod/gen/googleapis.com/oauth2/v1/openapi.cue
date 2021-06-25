// Google OAuth2 API
//
// Obtains end-user authorization grants for use with other Google
// APIs.
package oauth2

info: {
	contact: {
		name:        "Google"
		url:         "https://google.com"
		"x-twitter": "youtube"
	}
	description: "Obtains end-user authorization grants for use with other Google APIs."
	license: {
		name: "Creative Commons Attribution 3.0"
		url:  "http://creativecommons.org/licenses/by/3.0/"
	}
	termsOfService: "https://developers.google.com/terms/"
	title:          *"Google OAuth2 API" | string
	version:        *"v1" | string
	"x-apiClientRegistration": url: "https://console.developers.google.com"
	"x-apisguru-categories": ["analytics", "media"]
	"x-logo": url: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
	"x-origin": [{
		converter: {
			url:     "https://github.com/mermade/oas-kit"
			version: "7.0.4"
		}
		format:  "google"
		url:     "https://www.googleapis.com/discovery/v1/apis/oauth2/v1/rest"
		version: "v1"
	}]
	"x-preferred":    false
	"x-providerName": "googleapis.com"
	"x-serviceName":  "oauth2"
}

#Tokeninfo: {
	// Who is the intended audience for this token. In general the
	// same as issued_to.
	audience?: string

	// The email address of the user. Present only if the email scope
	// is present in the request.
	email?: string

	// Boolean flag which is true if the email address is verified.
	// Present only if the email scope is present in the request.
	email_verified?: bool

	// The expiry time of the token, as number of seconds left until
	// expiry.
	expires_in?: int

	// The issue time of the token, as number of seconds.
	issued_at?: int

	// To whom was the token issued to. In general the same as
	// audience.
	issued_to?: string

	// Who issued the token.
	issuer?: string

	// Nonce of the id token.
	nonce?: string

	// The space separated list of scopes granted to this token.
	scope?: string

	// The obfuscated user id.
	user_id?: string

	// Boolean flag which is true if the email address is verified.
	// Present only if the email scope is present in the request.
	verified_email?: bool
	...
}
#Userinfo: {
	// The user's email address.
	email?: string

	// The user's last name.
	family_name?: string

	// The user's gender.
	gender?: string

	// The user's first name.
	given_name?: string

	// The hosted domain e.g. example.com if the user is Google apps
	// user.
	hd?: string

	// The obfuscated ID of the user.
	id?: string

	// URL of the profile page.
	link?: string

	// The user's preferred locale.
	locale?: string

	// The user's full name.
	name?: string

	// URL of the user's picture image.
	picture?: string

	// Boolean flag which is true if the email address is verified.
	// Always verified because we only return the user's primary
	// email address.
	verified_email?: bool | *true
	...
}
