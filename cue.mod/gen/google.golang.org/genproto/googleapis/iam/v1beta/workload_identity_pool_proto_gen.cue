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
package iam

import "google.golang.org/protobuf/types/known/fieldmaskpb"

// Represents a collection of external workload identities. You can define IAM
// policies to grant these identities access to Google Cloud resources.
#WorkloadIdentityPool: {
	@protobuf(option (google.api.resource)=)

	// The current state of the pool.
	#State:
		#STATE_UNSPECIFIED |
		#ACTIVE |
		#DELETED

	// State unspecified.
	#STATE_UNSPECIFIED: 0

	// The pool is active, and may be used in Google Cloud policies.
	#ACTIVE: 1

	// The pool is soft-deleted. Soft-deleted pools are permanently deleted
	// after approximately 30 days. You can restore a soft-deleted pool using
	// [UndeleteWorkloadIdentityPool][google.iam.v1beta.WorkloadIdentityPools.UndeleteWorkloadIdentityPool].
	//
	// You cannot reuse the ID of a soft-deleted pool until it is permanently
	// deleted.
	//
	// While a pool is deleted, you cannot use it to exchange tokens, or use
	// existing tokens to access resources. If the pool is undeleted, existing
	// tokens grant access again.
	#DELETED: 2

	#State_value: {
		STATE_UNSPECIFIED: 0
		ACTIVE:            1
		DELETED:           2
	}

	// Output only. The resource name of the pool.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=OUTPUT_ONLY")

	// A display name for the pool. Cannot exceed 32 characters.
	displayName?: string @protobuf(2,string,name=display_name)

	// A description of the pool. Cannot exceed 256 characters.
	description?: string @protobuf(3,string)

	// Output only. The state of the pool.
	state?: #State @protobuf(4,State,"(google.api.field_behavior)=OUTPUT_ONLY")

	// Whether the pool is disabled. You cannot use a disabled pool to exchange
	// tokens, or use existing tokens to access resources. If
	// the pool is re-enabled, existing tokens grant access again.
	disabled?: bool @protobuf(5,bool)
}

// A configuration for an external identity provider.
#WorkloadIdentityPoolProvider: {
	@protobuf(option (google.api.resource)=)

	// Represents an Amazon Web Services identity provider.
	#Aws: {
		// Required. The AWS account ID.
		accountId?: string @protobuf(1,string,name=account_id,"(google.api.field_behavior)=REQUIRED")
	}

	// Represents an OpenId Connect 1.0 identity provider.
	#Oidc: {
		// Required. The OIDC issuer URL.
		issuerUri?: string @protobuf(1,string,name=issuer_uri,"(google.api.field_behavior)=REQUIRED")

		// Acceptable values for the `aud` field (audience) in the OIDC token. Token
		// exchange requests are rejected if the token audience does not match one
		// of the configured values. Each audience may be at most 256 characters. A
		// maximum of 10 audiences may be configured.
		//
		// If this list is empty, the OIDC token audience must be equal to
		// the full canonical resource name of the WorkloadIdentityPoolProvider,
		// with or without the HTTPS prefix. For example:
		//
		// ```
		// //iam.googleapis.com/projects/<project-number>/locations/<location>/workloadIdentityPools/<pool-id>/providers/<provider-id>
		// https://iam.googleapis.com/projects/<project-number>/locations/<location>/workloadIdentityPools/<pool-id>/providers/<provider-id>
		// ```
		allowedAudiences?: [...string] @protobuf(2,string,name=allowed_audiences)
	}

	// The current state of the provider.
	#State:
		#STATE_UNSPECIFIED |
		#ACTIVE |
		#DELETED

	// State unspecified.
	#STATE_UNSPECIFIED: 0

	// The provider is active, and may be used to validate authentication
	// credentials.
	#ACTIVE: 1

	// The provider is soft-deleted. Soft-deleted providers are permanently
	// deleted after approximately 30 days. You can restore a soft-deleted
	// provider using
	// [UndeleteWorkloadIdentityPoolProvider][google.iam.v1beta.WorkloadIdentityPools.UndeleteWorkloadIdentityPoolProvider].
	//
	// You cannot reuse the ID of a soft-deleted provider until it is
	// permanently deleted.
	#DELETED: 2

	#State_value: {
		STATE_UNSPECIFIED: 0
		ACTIVE:            1
		DELETED:           2
	}

	// Output only. The resource name of the provider.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=OUTPUT_ONLY")

	// A display name for the provider. Cannot exceed 32 characters.
	displayName?: string @protobuf(2,string,name=display_name)

	// A description for the provider. Cannot exceed 256 characters.
	description?: string @protobuf(3,string)

	// Output only. The state of the provider.
	state?: #State @protobuf(4,State,"(google.api.field_behavior)=OUTPUT_ONLY")

	// Whether the provider is disabled. You cannot use a disabled provider to
	// exchange tokens. However, existing tokens still grant access.
	disabled?: bool @protobuf(5,bool)

	// Maps attributes from authentication credentials issued by an external
	// identity provider to Google Cloud attributes, such as `subject` and
	// `segment`.
	//
	// Each key must be a string specifying the Google Cloud IAM attribute to
	// map to.
	//
	// The following keys are supported:
	//
	// * `google.subject`: The principal IAM is authenticating. You can reference
	//                     this value in IAM bindings. This is also the
	//                     subject that appears in Cloud Logging logs.
	//                     Cannot exceed 127 characters.
	//
	// * `google.groups`: Groups the external identity belongs to. You can grant
	//                    groups access to resources using an IAM `principalSet`
	//                    binding; access applies to all members of the group.
	//
	// You can also provide custom attributes by specifying
	// `attribute.{custom_attribute}`, where `{custom_attribute}` is the name of
	// the custom attribute to be mapped. You can define a maximum of 50 custom
	// attributes. The maximum length of a mapped attribute key is
	// 100 characters, and the key may only contain the characters [a-z0-9_].
	//
	// You can reference these attributes in IAM policies to define fine-grained
	// access for a workload to Google Cloud resources. For example:
	//
	// * `google.subject`:
	// `principal://iam.googleapis.com/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/subject/{value}`
	//
	// * `google.groups`:
	// `principalSet://iam.googleapis.com/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/group/{value}`
	//
	// * `attribute.{custom_attribute}`:
	// `principalSet://iam.googleapis.com/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/attribute.{custom_attribute}/{value}`
	//
	// Each value must be a [Common Expression Language]
	// (https://opensource.google/projects/cel) function that maps an
	// identity provider credential to the normalized attribute specified by the
	// corresponding map key.
	//
	// You can use the `assertion` keyword in the expression to access a JSON
	// representation of the authentication credential issued by the provider.
	//
	// The maximum length of an attribute mapping expression is 2048 characters.
	// When evaluated, the total size of all mapped attributes must not exceed
	// 8KB.
	//
	// For AWS providers, the following rules apply:
	//
	// - If no attribute mapping is defined, the following default mapping
	//   applies:
	//
	//   ```
	//   {
	//     "google.subject":"assertion.arn",
	//     "attribute.aws_role":
	//         "assertion.arn.contains('assumed-role')"
	//         " ? assertion.arn.extract('{account_arn}assumed-role/')"
	//         "   + 'assumed-role/'"
	//         "   + assertion.arn.extract('assumed-role/{role_name}/')"
	//         " : assertion.arn",
	//   }
	//   ```
	//
	// - If any custom attribute mappings are defined, they must include a mapping
	//   to the `google.subject` attribute.
	//
	//
	// For OIDC providers, the following rules apply:
	//
	// - Custom attribute mappings must be defined, and must include a mapping to
	//   the `google.subject` attribute. For example, the following maps the
	//   `sub` claim of the incoming credential to the `subject` attribute on
	//   a Google token.
	//
	//   ```
	//   {"google.subject": "assertion.sub"}
	//   ```
	attributeMapping?: {
		[string]: string
	} @protobuf(6,map[string]string,attribute_mapping)

	// [A Common Expression Language](https://opensource.google/projects/cel)
	// expression, in plain text, to restrict what otherwise valid authentication
	// credentials issued by the provider should not be accepted.
	//
	// The expression must output a boolean representing whether to allow the
	// federation.
	//
	// The following keywords may be referenced in the expressions:
	//
	// * `assertion`: JSON representing the authentication credential issued by
	//                the provider.
	// * `google`: The Google attributes mapped from the assertion in the
	//             `attribute_mappings`.
	// * `attribute`: The custom attributes mapped from the assertion in the
	//                `attribute_mappings`.
	//
	// The maximum length of the attribute condition expression is 4096
	// characters. If unspecified, all valid authentication credential are
	// accepted.
	//
	// The following example shows how to only allow credentials with a mapped
	// `google.groups` value of `admins`:
	//
	// ```
	// "'admins' in google.groups"
	// ```
	attributeCondition?: string @protobuf(7,string,name=attribute_condition)
	// Identity provider configuration types.
	{} | {
		// An Amazon Web Services identity provider.
		aws: #Aws @protobuf(8,Aws)
	} | {
		// An OpenId Connect 1.0 identity provider.
		oidc: #Oidc @protobuf(9,Oidc)
	}
}

// Request message for ListWorkloadIdentityPools.
#ListWorkloadIdentityPoolsRequest: {
	// Required. The parent resource to list pools for.
	parent?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The maximum number of pools to return.
	// If unspecified, at most 50 pools are returned.
	// The maximum value is 1000; values above are 1000 truncated to 1000.
	pageSize?: int32 @protobuf(2,int32,name=page_size)

	// A page token, received from a previous `ListWorkloadIdentityPools`
	// call. Provide this to retrieve the subsequent page.
	pageToken?: string @protobuf(3,string,name=page_token)

	// Whether to return soft-deleted pools.
	showDeleted?: bool @protobuf(4,bool,name=show_deleted)
}

// Response message for ListWorkloadIdentityPools.
#ListWorkloadIdentityPoolsResponse: {
	// A list of pools.
	workloadIdentityPools?: [...#WorkloadIdentityPool] @protobuf(1,WorkloadIdentityPool,name=workload_identity_pools)

	// A token, which can be sent as `page_token` to retrieve the next page.
	// If this field is omitted, there are no subsequent pages.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// Request message for GetWorkloadIdentityPool.
#GetWorkloadIdentityPoolRequest: {
	// Required. The name of the pool to retrieve.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Request message for CreateWorkloadIdentityPool.
#CreateWorkloadIdentityPoolRequest: {
	// Required. The parent resource to create the pool in. The only supported
	// location is `global`.
	parent?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Required. The pool to create.
	workloadIdentityPool?: #WorkloadIdentityPool @protobuf(2,WorkloadIdentityPool,name=workload_identity_pool,"(google.api.field_behavior)=REQUIRED")

	// Required. The ID to use for the pool, which becomes the
	// final component of the resource name. This value should be 4-32 characters,
	// and may contain the characters [a-z0-9-]. The prefix `gcp-` is
	// reserved for use by Google, and may not be specified.
	workloadIdentityPoolId?: string @protobuf(3,string,name=workload_identity_pool_id,"(google.api.field_behavior)=REQUIRED")
}

// Request message for UpdateWorkloadIdentityPool.
#UpdateWorkloadIdentityPoolRequest: {
	// Required. The pool to update. The `name` field is used to identify the pool.
	workloadIdentityPool?: #WorkloadIdentityPool @protobuf(1,WorkloadIdentityPool,name=workload_identity_pool,"(google.api.field_behavior)=REQUIRED")

	// Required. The list of fields update.
	updateMask?: fieldmaskpb.#FieldMask @protobuf(2,google.protobuf.FieldMask,name=update_mask,"(google.api.field_behavior)=REQUIRED")
}

// Request message for DeleteWorkloadIdentityPool.
#DeleteWorkloadIdentityPoolRequest: {
	// Required. The name of the pool to delete.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Request message for UndeleteWorkloadIdentityPool.
#UndeleteWorkloadIdentityPoolRequest: {
	// Required. The name of the pool to undelete.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Request message for ListWorkloadIdentityPoolProviders.
#ListWorkloadIdentityPoolProvidersRequest: {
	// Required. The pool to list providers for.
	parent?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// The maximum number of providers to return.
	// If unspecified, at most 50 providers are returned.
	// The maximum value is 100; values above 100 are truncated to 100.
	pageSize?: int32 @protobuf(2,int32,name=page_size)

	// A page token, received from a previous
	// `ListWorkloadIdentityPoolProviders` call. Provide this to retrieve the
	// subsequent page.
	pageToken?: string @protobuf(3,string,name=page_token)

	// Whether to return soft-deleted providers.
	showDeleted?: bool @protobuf(4,bool,name=show_deleted)
}

// Response message for ListWorkloadIdentityPoolProviders.
#ListWorkloadIdentityPoolProvidersResponse: {
	// A list of providers.
	workloadIdentityPoolProviders?: [...#WorkloadIdentityPoolProvider] @protobuf(1,WorkloadIdentityPoolProvider,name=workload_identity_pool_providers)

	// A token, which can be sent as `page_token` to retrieve the next page.
	// If this field is omitted, there are no subsequent pages.
	nextPageToken?: string @protobuf(2,string,name=next_page_token)
}

// Request message for GetWorkloadIdentityPoolProvider.
#GetWorkloadIdentityPoolProviderRequest: {
	// Required. The name of the provider to retrieve.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Request message for CreateWorkloadIdentityPoolProvider.
#CreateWorkloadIdentityPoolProviderRequest: {
	// Required. The pool to create this provider in.
	parent?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")

	// Required. The provider to create.
	workloadIdentityPoolProvider?: #WorkloadIdentityPoolProvider @protobuf(2,WorkloadIdentityPoolProvider,name=workload_identity_pool_provider,"(google.api.field_behavior)=REQUIRED")

	// Required. The ID for the provider, which becomes the
	// final component of the resource name. This value must be 4-32 characters,
	// and may contain the characters [a-z0-9-]. The prefix `gcp-` is
	// reserved for use by Google, and may not be specified.
	workloadIdentityPoolProviderId?: string @protobuf(3,string,name=workload_identity_pool_provider_id,"(google.api.field_behavior)=REQUIRED")
}

// Request message for UpdateWorkloadIdentityPoolProvider.
#UpdateWorkloadIdentityPoolProviderRequest: {
	// Required. The provider to update.
	workloadIdentityPoolProvider?: #WorkloadIdentityPoolProvider @protobuf(1,WorkloadIdentityPoolProvider,name=workload_identity_pool_provider,"(google.api.field_behavior)=REQUIRED")

	// Required. The list of fields to update.
	updateMask?: fieldmaskpb.#FieldMask @protobuf(2,google.protobuf.FieldMask,name=update_mask,"(google.api.field_behavior)=REQUIRED")
}

// Request message for DeleteWorkloadIdentityPoolProvider.
#DeleteWorkloadIdentityPoolProviderRequest: {
	// Required. The name of the provider to delete.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Request message for UndeleteWorkloadIdentityPoolProvider.
#UndeleteWorkloadIdentityPoolProviderRequest: {
	// Required. The name of the provider to undelete.
	name?: string @protobuf(1,string,"(google.api.field_behavior)=REQUIRED","(google.api.resource_reference)=")
}

// Metadata for long-running WorkloadIdentityPool operations.
#WorkloadIdentityPoolOperationMetadata: {
}

// Metadata for long-running WorkloadIdentityPoolProvider operations.
#WorkloadIdentityPoolProviderOperationMetadata: {
}
