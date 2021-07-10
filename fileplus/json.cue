package fileplus

import (
	"tool/file"
	"encoding/json"
)

ReadJSON: file.Read & {
	contents: string
	parsed_contents: json.Unmarshal(contents)
}