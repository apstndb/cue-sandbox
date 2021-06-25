// Copyright 2020 Google LLC
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
package longrunning

import (
	"google.golang.org/genproto/googleapis/rpc/status"
	"time"
)

// This resource represents a long-running operation that is the result of a
// network API call.
#Operation: {
	// The server-assigned name, which is only unique within the same service that
	// originally returns it. If you use the default HTTP mapping, the
	// `name` should be a resource name ending with `operations/{unique_id}`.
	name?: string @protobuf(1,string)

	// Service-specific metadata associated with the operation.  It typically
	// contains progress information and common metadata such as create time.
	// Some services might not provide such metadata.  Any method that returns a
	// long-running operation should document the metadata type, if any.
	metadata?: {
		// A URL/resource name that uniquely identifies the type of the serialized protocol buffer message. This string must contain at least one "/" character. The last segment of the URL's path must represent the fully qualified name of the type (as in `type.googleapis.com/google.protobuf.Duration`). The name should be in a canonical form (e.g., leading "." is not accepted).
		// The remaining fields of this object correspond to fields of the proto messsage. If the embedded message is well-known and has a custom JSON representation, that representation is assigned to the 'value' field.
		"@type": string
	} @protobuf(2,google.protobuf.Any)

	// If the value is `false`, it means the operation is still in progress.
	// If `true`, the operation is completed, and either `error` or `response` is
	// available.
	done?: bool @protobuf(3,bool)
	// The operation result, which can be either an `error` or a valid `response`.
	// If `done` == `false`, neither `error` nor `response` is set.
	// If `done` == `true`, exactly one of `error` or `response` is set.
	{} | {
		// The error result of the operation in case of failure or cancellation.
		error: status.#Status @protobuf(4,google.rpc.Status)
	} | {
		// The normal response of the operation in case of success.  If the original
		// method returns no data on success, such as `Delete`, the response is
		// `google.protobuf.Empty`.  If the original method is standard
		// `Get`/`Create`/`Update`, the response should be the resource.  For other
		// methods, the response should have the type `XxxResponse`, where `Xxx`
		// is the original method name.  For example, if the original method name
		// is `TakeSnapshot()`, the inferred response type is
		// `TakeSnapshotResponse`.
		response: {
			// A URL/resource name that uniquely identifies the type of the serialized protocol buffer message. This string must contain at least one "/" character. The last segment of the URL's path must represent the fully qualified name of the type (as in `type.googleapis.com/google.protobuf.Duration`). The name should be in a canonical form (e.g., leading "." is not accepted).
			// The remaining fields of this object correspond to fields of the proto messsage. If the embedded message is well-known and has a custom JSON representation, that representation is assigned to the 'value' field.
			"@type": string
		} @protobuf(5,google.protobuf.Any)
	}
}

// The request message for [Operations.GetOperation][google.longrunning.Operations.GetOperation].
#GetOperationRequest: {
	// The name of the operation resource.
	name?: string @protobuf(1,string)
}

// The request message for [Operations.ListOperations][google.longrunning.Operations.ListOperations].
#ListOperationsRequest: {
	// The name of the operation's parent resource.
	name?: string @protobuf(4,string)

	// The standard list filter.
	filter?: string @protobuf(1,string)

	// The standard list page size.
	pageSize?: int32 @protobuf(2,int32,name=page_size)

	// The standard list page token.
	pageToken?: string @protobuf(3,string,name=page_token)
}

// The response message for [Operations.ListOperations][google.longrunning.Operations.ListOperations].
#ListOperationsResponse: {
	// A list of operations that matches the specified filter in the request.
	operations?: [...#Operation] @protobuf(1,Operation)

	// The standard List next-page token.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// The request message for [Operations.CancelOperation][google.longrunning.Operations.CancelOperation].
#CancelOperationRequest: {
	// The name of the operation resource to be cancelled.
	name?: string @protobuf(1,string)
}

// The request message for [Operations.DeleteOperation][google.longrunning.Operations.DeleteOperation].
#DeleteOperationRequest: {
	// The name of the operation resource to be deleted.
	name?: string @protobuf(1,string)
}

// The request message for [Operations.WaitOperation][google.longrunning.Operations.WaitOperation].
#WaitOperationRequest: {
	// The name of the operation resource to wait on.
	name?: string @protobuf(1,string)

	// The maximum duration to wait before timing out. If left blank, the wait
	// will be at most the time permitted by the underlying HTTP/RPC protocol.
	// If RPC context deadline is also specified, the shorter one will be used.
	timeout?: time.Duration @protobuf(2,google.protobuf.Duration)
}

// A message representing the message types used by a long-running operation.
//
// Example:
//
//   rpc LongRunningRecognize(LongRunningRecognizeRequest)
//       returns (google.longrunning.Operation) {
//     option (google.longrunning.operation_info) = {
//       response_type: "LongRunningRecognizeResponse"
//       metadata_type: "LongRunningRecognizeMetadata"
//     };
//   }
#OperationInfo: {
	// Required. The message name of the primary return type for this
	// long-running operation.
	// This type will be used to deserialize the LRO's response.
	//
	// If the response is in a different package from the rpc, a fully-qualified
	// message name must be used (e.g. `google.protobuf.Struct`).
	//
	// Note: Altering this value constitutes a breaking change.
	responseType?: string @protobuf(1,string,name=response_type)

	// Required. The message name of the metadata type for this long-running
	// operation.
	//
	// If the response is in a different package from the rpc, a fully-qualified
	// message name must be used (e.g. `google.protobuf.Struct`).
	//
	// Note: Altering this value constitutes a breaking change.
	metadataType?: string @protobuf(2,string,name=metadata_type)
}
