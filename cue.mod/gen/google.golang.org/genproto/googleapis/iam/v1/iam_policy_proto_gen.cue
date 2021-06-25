// Copyright 2019 Google LLC.
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
//
package iam

// Request message for `SetIamPolicy` method.
#SetIamPolicyRequest: {
	// REQUIRED: The resource for which the policy is being specified.
	// See the operation documentation for the appropriate value for this field.
	resource?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED",#"(google.api.resource_reference).type="*""#)

	// REQUIRED: The complete policy to be applied to the `resource`. The size of
	// the policy is limited to a few 10s of KB. An empty policy is a
	// valid policy but certain Cloud Platform services (such as Projects)
	// might reject them.
	policy?: #Policy @protobuf(2,Policy,"(google.api.field_behavior)=REQUIRED")
}

// Request message for `GetIamPolicy` method.
#GetIamPolicyRequest: {
	// REQUIRED: The resource for which the policy is being requested.
	// See the operation documentation for the appropriate value for this field.
	resource?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED",#"(google.api.resource_reference).type="*""#)

	// OPTIONAL: A `GetPolicyOptions` object for specifying options to
	// `GetIamPolicy`. This field is only used by Cloud IAM.
	options?: #GetPolicyOptions @protobuf(2,GetPolicyOptions)
}

// Request message for `TestIamPermissions` method.
#TestIamPermissionsRequest: {
	// REQUIRED: The resource for which the policy detail is being requested.
	// See the operation documentation for the appropriate value for this field.
	resource?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED",#"(google.api.resource_reference).type="*""#)

	// The set of permissions to check for the `resource`. Permissions with
	// wildcards (such as '*' or 'storage.*') are not allowed. For more
	// information see
	// [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
	permissions?: [...string] @protobuf(2,string,"(google.api.field_behavior)=REQUIRED")
}

// Response message for `TestIamPermissions` method.
#TestIamPermissionsResponse: {
	// A subset of `TestPermissionsRequest.permissions` that the caller is
	// allowed.
	permissions?: [...string] @protobuf(1,string)
}
