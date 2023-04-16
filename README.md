# aws-oidc-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.oidc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.certificates](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_client_ids"></a> [oidc\_client\_ids](#input\_oidc\_client\_ids) | IDs of authenticated clients | `list(string)` | n/a | yes |
| <a name="input_oidc_provider_url"></a> [oidc\_provider\_url](#input\_oidc\_provider\_url) | OIDC token provider url | `string` | n/a | yes |
| <a name="input_policy_documents"></a> [policy\_documents](#input\_policy\_documents) | Conditions for authenticating to a role | <pre>map(object(<br>    {<br>      actions = optional(list(string), ["sts:AssumeRoleWithWebIdentity"])<br>      effect  = optional(string, "Allow")<br>      conditions = map(object(<br>        {<br>          values   = list(string)<br>          test     = string<br>          variable = string<br>        }<br>      ))<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | Conditions for authenticating to a role | <pre>list(object(<br>    {<br>      name                      = string<br>      description               = string<br>      policy_document_reference = string<br>      force_detach_policies     = optional(bool, false)<br>      max_session_duration      = optional(number, 3600)<br>      path                      = string<br>      permissions_boundary      = string<br>      inline_policies = optional(list(object(<br>        {<br>          name  = string<br>          value = string<br>        }<br>      )), [])<br>      policy_arns = list(string)<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to be applied to all resources. | `map(string)` | `{}` | no |
| <a name="input_thumbprint_urls"></a> [thumbprint\_urls](#input\_thumbprint\_urls) | URLs for certificates (typically ends in .well-known/openid-configuration) | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
