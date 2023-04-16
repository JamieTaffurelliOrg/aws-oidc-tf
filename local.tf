locals {
  policy_attachments = distinct(flatten([
    for role in var.roles : [
      for policy_arn in role.policy_arns : {
        role       = aws_iam_role.roles[role.name].id
        policy_arn = policy_arn
      }
  ]]))
}
