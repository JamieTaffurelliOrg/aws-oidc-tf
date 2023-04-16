variable "oidc_provider_url" {
  type        = string
  description = "OIDC token provider url"
}

variable "oidc_client_ids" {
  type        = list(string)
  description = "IDs of authenticated clients"
}

variable "thumbprint_urls" {
  type        = list(string)
  description = "URLs for certificates (typically ends in .well-known/openid-configuration)"
}

variable "policy_documents" {
  type = map(object(
    {
      actions = optional(list(string), ["sts:AssumeRoleWithWebIdentity"])
      effect  = optional(string, "Allow")
      conditions = map(object(
        {
          values   = list(string)
          test     = string
          variable = string
        }
      ))
    }
  ))
  description = "Conditions for authenticating to a role"
}

variable "roles" {
  type = list(object(
    {
      name                      = string
      description               = string
      policy_document_reference = string
      force_detach_policies     = optional(bool, false)
      max_session_duration      = optional(number, 3600)
      path                      = string
      permissions_boundary      = string
      inline_policies = optional(list(object(
        {
          name  = string
          value = string
        }
      )), [])
      policy_arns = list(string)
    }
  ))
  description = "Conditions for authenticating to a role"
}

variable "tags" {
  default     = {}
  description = "Map of tags to be applied to all resources."
  type        = map(string)
}
