package gcpauth

import "tool/exec"

import "strings"

GcloudIDToken: exec.Run & {
	cmd:    "gcloud auth print-identity-token"
	stdout: string
	token:  strings.TrimSpace(stdout)
}

GcloudAccessToken: exec.Run & {
	cmd:    "gcloud auth application-default print-access-token"
	stdout: string
	token:  strings.TrimSpace(stdout)
}
