data "aws_iam_policy_document" "assume_role" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test = "StringLike"
      values = [
        for repo in var.github_repositories :
        "repo:%{if length(regexall(":+", repo)) > 0}${repo}%{else}${repo}:*%{endif}"
      ]
      variable = "token.actions.githubusercontent.com:sub"
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.github.arn]
      type        = "Federated"
    }
  }

  version = "2012-10-17"
}

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}
