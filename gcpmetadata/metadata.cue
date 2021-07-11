package metadata
import (
	"tool/http"
)

Metadata: http.Get & {
	metadata: string
url: "http://169.254.169.254/computeMetadata/v1/\(metadata)"
request: header: "metadata-flavor": "Google"
}
