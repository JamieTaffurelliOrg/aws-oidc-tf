resource "aws_iam_role" "github" {
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  description           = "Role assumed by the GitHub OIDC provider."
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  name                  = var.iam_role_name
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary
  tags                  = var.tags

  dynamic "inline_policy" {
    for_each = var.iam_role_inline_policies

    content {
      name   = inline_policy.key
      policy = inline_policy.value
    }
  }
}

resource "aws_iam_role_policy_attachment" "policies" {
  for_each = toset(var.iam_role_policy_arns)

  policy_arn = each.key
  role       = aws_iam_role.github.id
}

resource "aws_iam_openid_connect_provider" "github" {
  client_id_list = concat(
    [for org in local.github_organizations : "https://github.com/${org}"],
    ["sts.amazonaws.com"]
  )

  url             = "https://token.actions.githubusercontent.com"
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]

  tags = var.tags
}
