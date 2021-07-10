package jwt

import (
	"encoding/json"
	"tool/exec"
	"github.com/apstndb/cue-sandbox/base64"
)

#JwtPayload: {
	claims: {...}
	header: {alg: "RS256", typ: "JWT"}
	output: (#JSONBase64URL & {input: header}).output + "." + (#JSONBase64URL & {input: claims}).output
}

#JSONBase64URL: {
	input: {...}
	let Input = input
	output: (base64.#Base64URL & {input: json.Marshal(Input)}).output
}

SignJwt: exec.Run & {
	// input
	privateKeyPem: string
	claims: {}
	let Claims = claims

	cmd: ["./sign"]
	env: PRIVATE_KEY_PEM: privateKeyPem
	stdin:  (#JwtPayload & {claims: Claims}).output
	stdout: string

	output: stdin + "." + stdout
}

SimpleJwt: exec.Run & {
	// input
	privateKeyPem: string
	claims: {}

	cmd: ["simplejwt"]
	env: PRIVATE_KEY_PEM: privateKeyPem
	stdin:  json.Marshal(claims)
	stdout: string
}
