// Copyright 2021 Google LLC
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
package admin

// Audit log information specific to Cloud IAM admin APIs. This message is
// serialized as an `Any` type in the `ServiceData` message of an
// `AuditLog` message.
#AuditData: {
	// A PermissionDelta message to record the added_permissions and
	// removed_permissions inside a role.
	#PermissionDelta: {
		// Added permissions.
		addedPermissions?: [...string] @protobuf(1,string,name=added_permissions)

		// Removed permissions.
		removedPermissions?: [...string] @protobuf(2,string,name=removed_permissions)
	}

	// The permission_delta when when creating or updating a Role.
	permissionDelta?: #PermissionDelta @protobuf(1,PermissionDelta,name=permission_delta)
}
