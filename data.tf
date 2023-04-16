data "aws_iam_policy_document" "assume_role" {
  for_each = var.policy_documents

  statement {
    actions = each.value["actions"]
    effect  = each.value["effect"]

    dynamic "condition" {
      for_each = each.value["conditions"]

      content {
        test     = condition.value["test"]
        values   = condition.value["values"]
        variable = condition.value["variable"]
      }
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
      type        = "Federated"
    }
  }

  version = "2012-10-17"
}

data "tls_certificate" "certificates" {
  count = length(var.thumbprint_urls)
  url   = var.thumbprint_urls[count.index]
}
