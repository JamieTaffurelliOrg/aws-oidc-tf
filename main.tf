resource "aws_iam_role" "roles" {
  for_each              = { for k in var.roles : k.name => k }
  name                  = each.key
  assume_role_policy    = data.aws_iam_policy_document.assume_role[each.value["policy_document_reference"]].json
  description           = each.value["description"]
  force_detach_policies = each.value["force_detach_policies"]
  max_session_duration  = each.value["max_session_duration"]
  path                  = each.value["path"]
  permissions_boundary  = each.value["permissions_boundary"]

  dynamic "inline_policy" {
    for_each = { for k in each.value["inline_policies"] : k.name => k if k != null }

    content {
      name   = inline_policy.key
      policy = inline_policy.value
    }
  }

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "policies" {
  for_each = { for k in local.policy_attachments : "${k.role_name}-${k.policy_arn}" => k }

  policy_arn = each.value["policy_arn"]
  role       = aws_iam_role.roles[(each.value["role_name"])].id
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  url             = var.oidc_provider_url
  client_id_list  = var.oidc_client_ids
  thumbprint_list = data.tls_certificate.certificates[*].certificates[0].sha1_fingerprint

  tags = var.tags
}
