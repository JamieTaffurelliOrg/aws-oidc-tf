locals {
  github_organizations = toset([for repo in var.github_repositories : split("/", repo)[0]])
}
