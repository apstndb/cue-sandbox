// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package logging

import "google.golang.org/genproto/googleapis/iam/v1:iam"

// Audit log information specific to Cloud IAM. This message is serialized
// as an `Any` type in the `ServiceData` message of an
// `AuditLog` message.
#AuditData: {
	// Policy delta between the original policy and the newly set policy.
	policyDelta?: iam.#PolicyDelta @protobuf(2,google.iam.v1.PolicyDelta,name=policy_delta)
}
