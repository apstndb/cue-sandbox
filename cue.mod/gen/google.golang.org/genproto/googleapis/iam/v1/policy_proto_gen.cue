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

import "google.golang.org/genproto/googleapis/type/expr"

// Defines an Identity and Access Management (IAM) policy. It is used to
// specify access control policies for Cloud Platform resources.
//
//
// A `Policy` is a collection of `bindings`. A `binding` binds one or more
// `members` to a single `role`. Members can be user accounts, service accounts,
// Google groups, and domains (such as G Suite). A `role` is a named list of
// permissions (defined by IAM or configured by users). A `binding` can
// optionally specify a `condition`, which is a logic expression that further
// constrains the role binding based on attributes about the request and/or
// target resource.
//
// **JSON Example**
//
//     {
//       "bindings": [
//         {
//           "role": "roles/resourcemanager.organizationAdmin",
//           "members": [
//             "user:mike@example.com",
//             "group:admins@example.com",
//             "domain:google.com",
//             "serviceAccount:my-project-id@appspot.gserviceaccount.com"
//           ]
//         },
//         {
//           "role": "roles/resourcemanager.organizationViewer",
//           "members": ["user:eve@example.com"],
//           "condition": {
//             "title": "expirable access",
//             "description": "Does not grant access after Sep 2020",
//             "expression": "request.time <
//             timestamp('2020-10-01T00:00:00.000Z')",
//           }
//         }
//       ]
//     }
//
// **YAML Example**
//
//     bindings:
//     - members:
//       - user:mike@example.com
//       - group:admins@example.com
//       - domain:google.com
//       - serviceAccount:my-project-id@appspot.gserviceaccount.com
//       role: roles/resourcemanager.organizationAdmin
//     - members:
//       - user:eve@example.com
//       role: roles/resourcemanager.organizationViewer
//       condition:
//         title: expirable access
//         description: Does not grant access after Sep 2020
//         expression: request.time < timestamp('2020-10-01T00:00:00.000Z')
//
// For a description of IAM and its features, see the
// [IAM developer's guide](https://cloud.google.com/iam/docs).
#Policy: {
	// Specifies the format of the policy.
	//
	// Valid values are 0, 1, and 3. Requests specifying an invalid value will be
	// rejected.
	//
	// Operations affecting conditional bindings must specify version 3. This can
	// be either setting a conditional policy, modifying a conditional binding,
	// or removing a binding (conditional or unconditional) from the stored
	// conditional policy.
	// Operations on non-conditional policies may specify any valid value or
	// leave the field unset.
	//
	// If no etag is provided in the call to `setIamPolicy`, version compliance
	// checks against the stored policy is skipped.
	version?: int32 @protobuf(1,int32)

	// Associates a list of `members` to a `role`. Optionally may specify a
	// `condition` that determines when binding is in effect.
	// `bindings` with no members will result in an error.
	bindings?: [...#Binding] @protobuf(4,Binding)

	// `etag` is used for optimistic concurrency control as a way to help
	// prevent simultaneous updates of a policy from overwriting each other.
	// It is strongly suggested that systems make use of the `etag` in the
	// read-modify-write cycle to perform policy updates in order to avoid race
	// conditions: An `etag` is returned in the response to `getIamPolicy`, and
	// systems are expected to put that etag in the request to `setIamPolicy` to
	// ensure that their change will be applied to the same version of the policy.
	//
	// If no `etag` is provided in the call to `setIamPolicy`, then the existing
	// policy is overwritten. Due to blind-set semantics of an etag-less policy,
	// 'setIamPolicy' will not fail even if the incoming policy version does not
	// meet the requirements for modifying the stored policy.
	etag?: bytes @protobuf(3,bytes)
}

// Associates `members` with a `role`.
#Binding: {
	// Role that is assigned to `members`.
	// For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
	role?: string @protobuf(1,string)

	// Specifies the identities requesting access for a Cloud Platform resource.
	// `members` can have the following values:
	//
	// * `allUsers`: A special identifier that represents anyone who is
	//    on the internet; with or without a Google account.
	//
	// * `allAuthenticatedUsers`: A special identifier that represents anyone
	//    who is authenticated with a Google account or a service account.
	//
	// * `user:{emailid}`: An email address that represents a specific Google
	//    account. For example, `alice@example.com` .
	//
	//
	// * `serviceAccount:{emailid}`: An email address that represents a service
	//    account. For example, `my-other-app@appspot.gserviceaccount.com`.
	//
	// * `group:{emailid}`: An email address that represents a Google group.
	//    For example, `admins@example.com`.
	//
	//
	// * `domain:{domain}`: The G Suite domain (primary) that represents all the
	//    users of that domain. For example, `google.com` or `example.com`.
	//
	//
	members?: [...string] @protobuf(2,string)

	// The condition that is associated with this binding.
	// NOTE: An unsatisfied condition will not allow user access via current
	// binding. Different bindings, including their conditions, are examined
	// independently.
	condition?: expr.#Expr @protobuf(3,google.type.Expr)
}

// The difference delta between two policies.
#PolicyDelta: {
	// The delta for Bindings between two policies.
	bindingDeltas?: [...#BindingDelta] @protobuf(1,BindingDelta,name=binding_deltas)

	// The delta for AuditConfigs between two policies.
	auditConfigDeltas?: [...#AuditConfigDelta] @protobuf(2,AuditConfigDelta,name=audit_config_deltas)
}

// One delta entry for Binding. Each individual change (only one member in each
// entry) to a binding will be a separate entry.
#BindingDelta: {
	// The type of action performed on a Binding in a policy.
	#Action:
		#ACTION_UNSPECIFIED |
		#ADD |
		#REMOVE

	// Unspecified.
	#ACTION_UNSPECIFIED: 0

	// Addition of a Binding.
	#ADD: 1

	// Removal of a Binding.
	#REMOVE: 2

	#Action_value: {
		ACTION_UNSPECIFIED: 0
		ADD:                1
		REMOVE:             2
	}

	// The action that was performed on a Binding.
	// Required
	action?: #Action @protobuf(1,Action)

	// Role that is assigned to `members`.
	// For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
	// Required
	role?: string @protobuf(2,string)

	// A single identity requesting access for a Cloud Platform resource.
	// Follows the same format of Binding.members.
	// Required
	member?: string @protobuf(3,string)

	// The condition that is associated with this binding.
	condition?: expr.#Expr @protobuf(4,google.type.Expr)
}

// One delta entry for AuditConfig. Each individual change (only one
// exempted_member in each entry) to a AuditConfig will be a separate entry.
#AuditConfigDelta: {
	// The type of action performed on an audit configuration in a policy.
	#Action:
		#ACTION_UNSPECIFIED |
		#ADD |
		#REMOVE

	// Unspecified.
	#ACTION_UNSPECIFIED: 0

	// Addition of an audit configuration.
	#ADD: 1

	// Removal of an audit configuration.
	#REMOVE: 2

	#Action_value: {
		ACTION_UNSPECIFIED: 0
		ADD:                1
		REMOVE:             2
	}

	// The action that was performed on an audit configuration in a policy.
	// Required
	action?: #Action @protobuf(1,Action)

	// Specifies a service that was configured for Cloud Audit Logging.
	// For example, `storage.googleapis.com`, `cloudsql.googleapis.com`.
	// `allServices` is a special value that covers all services.
	// Required
	service?: string @protobuf(2,string)

	// A single identity that is exempted from "data access" audit
	// logging for the `service` specified above.
	// Follows the same format of Binding.members.
	exemptedMember?: string @protobuf(3,string,name=exempted_member)

	// Specifies the log_type that was be enabled. ADMIN_ACTIVITY is always
	// enabled, and cannot be configured.
	// Required
	logType?: string @protobuf(4,string,name=log_type)
}
