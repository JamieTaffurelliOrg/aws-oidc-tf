locals {
  policy_attachments = distinct(flatten([
    for role in var.roles : [
      for policy_arn_id in role.policy_arns : {
        role_name  = role.name
        policy_arn = policy_arn_id
      }
  ]]))
}
