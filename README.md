
[![Terraform Validation](https://github.com/HappyPathway/terraform-aws-ecr-clone/actions/workflows/terraform.yaml/badge.svg)](https://github.com/HappyPathway/terraform-aws-ecr-clone/actions/workflows/terraform.yaml)

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.apps_repos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.image_repos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [null_resource.copy_images](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecr_authorization_token.token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_authorization_token) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_alias"></a> [account\_alias](#input\_account\_alias) | AWS Account Alias | `string` | `""` | no |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS Account ID (default will pull from current user) | `string` | `""` | no |
| <a name="input_application_list"></a> [application\_list](#input\_application\_list) | List of application repositories to create for /{application\_name}/{image\_name} for those not in image\_config | `list(string)` | `[]` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Appliication name, usually {org}-{project}, which is likely a prefix to the EKS cluster name | `string` | n/a | yes |
| <a name="input_destination_insecure"></a> [destination\_insecure](#input\_destination\_insecure) | Destination registry is insecure | `string` | `false` | no |
| <a name="input_destination_password"></a> [destination\_password](#input\_destination\_password) | OCI destination repository password | `string` | `null` | no |
| <a name="input_destination_username"></a> [destination\_username](#input\_destination\_username) | OCI destination repository username | `string` | `null` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | The encryption configuration for the repository. Must be one of: AES256 or KMS | `string` | `"KMS"` | no |
| <a name="input_image_config"></a> [image\_config](#input\_image\_config) | List of image configuration objects to copy from SOURCE to DESTINATION | <pre>list(object({<br>    name            = string,<br>    tag             = string,<br>    dest_path       = string,<br>    source_registry = string,<br>    source_image    = string,<br>    source_tag      = optional(string),<br>    enabled         = bool,<br>  }))</pre> | `[]` | no |
| <a name="input_image_scan_on_push"></a> [image\_scan\_on\_push](#input\_image\_scan\_on\_push) | The image scanning configuration for the repository. Must be one of: true or false | `bool` | `true` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The image tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE | `string` | `"MUTABLE"` | no |
| <a name="input_override_prefixes"></a> [override\_prefixes](#input\_override\_prefixes) | Override built-in prefixes by component. This should be used primarily for common infrastructure things | `map(string)` | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | Region in which to create the ECR repositories (default of current region) | `string` | `null` | no |
| <a name="input_source_insecure"></a> [source\_insecure](#input\_source\_insecure) | Source registry is insecure | `string` | `false` | no |
| <a name="input_source_password"></a> [source\_password](#input\_source\_password) | OCI source repository password | `string` | `""` | no |
| <a name="input_source_username"></a> [source\_username](#input\_source\_username) | OCI source repository username | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags to apply to appropriate resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_images"></a> [images](#output\_images) | Final full merge of images with extra details |
<!-- END_TF_DOCS -->