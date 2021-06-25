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
package status

// The `Status` type defines a logical error model that is suitable for
// different programming environments, including REST APIs and RPC APIs. It is
// used by [gRPC](https://github.com/grpc). Each `Status` message contains
// three pieces of data: error code, error message, and error details.
//
// You can find out more about this error model and how to work with it in the
// [API Design Guide](https://cloud.google.com/apis/design/errors).
#Status: {
	// The status code, which should be an enum value of [google.rpc.Code][google.rpc.Code].
	code?: int32 @protobuf(1,int32)

	// A developer-facing error message, which should be in English. Any
	// user-facing error message should be localized and sent in the
	// [google.rpc.Status.details][google.rpc.Status.details] field, or localized by the client.
	message?: string @protobuf(2,string)

	// A list of messages that carry the error details.  There is a common set of
	// message types for APIs to use.
	details?: [...{
		// A URL/resource name that uniquely identifies the type of the serialized protocol buffer message. This string must contain at least one "/" character. The last segment of the URL's path must represent the fully qualified name of the type (as in `type.googleapis.com/google.protobuf.Duration`). The name should be in a canonical form (e.g., leading "." is not accepted).
		// The remaining fields of this object correspond to fields of the proto messsage. If the embedded message is well-known and has a custom JSON representation, that representation is assigned to the 'value' field.
		"@type": string
	}] @protobuf(3,google.protobuf.Any)
}
