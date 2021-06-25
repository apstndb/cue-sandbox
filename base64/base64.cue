package base64

import (
	"strings"
	"encoding/base64"
)

#Base64URL: {
	input:  string
	output: strings.Replace(strings.Replace(strings.Replace(base64.Encode(null, input), "+", "-", -1), "/", "_", -1), "=", "", -1)
}
