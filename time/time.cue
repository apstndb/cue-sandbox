package time

import (
	"tool/exec"
	"strconv"
	"strings"
)

UnixNow: exec.Run & {
	cmd: ["date", "+%s"]
	stdout: string
	output: strconv.ParseInt(strings.TrimSpace(stdout), 10, 64)
}
