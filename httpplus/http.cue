package httpplus

import (
	"tool/http"
	"encoding/json"
)

Do: http.Do & {
	request: header: "content-type": "application/json"

	bearer_token?: string
	request: header: {
		if bearer_token != _|_ {
			Authorization: "Bearer \(bearer_token)"
		}
	}

	request_body?: {}
	request: {
		if request_body != _|_ {
			body: json.Marshal(request_body)
		}
	}

	response: body: string
	response_body: json.Unmarshal(response.body)
}

Post: Do & http.Post
Get:  Do & http.Get
