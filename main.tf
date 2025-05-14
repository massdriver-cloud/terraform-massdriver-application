locals {
  # These trys are here so that terraform validate will pass in CI.
  # We dont want to require the user to pass in the path to their MD bundle and requiring
  # everyone to parse the right files and pass them in is error prone. :tada:
  app_specification    = try(yamldecode(file("/massdriver/bundle/massdriver.yaml")), {})
  connections          = try(jsondecode(file("${path.root}/_connections.auto.tfvars.json")), {})
  params               = try(jsondecode(file("${path.root}/_params.auto.tfvars.json")), {})
  secrets              = try(jsondecode(file("/massdriver/secrets.json")), {})
  envs                 = try(jsondecode(file("/massdriver/envs.json")), {})
  app_block            = lookup(local.app_specification, "app", {})
  app_policies_queries = toset(lookup(local.app_block, "policies", []))

  inputs_json = jsonencode({
    params      = local.params
    connections = local.connections
    secrets     = local.secrets
  })

  policies = { for p in local.app_policies_queries : p => jsondecode(data.jq_query.policies[p].result) }
}

data "jq_query" "policies" {
  for_each = local.app_policies_queries
  data     = local.inputs_json
  query    = each.value
}

output "policies" {
  description = "The policies parsed from massdriver.yaml"
  value       = local.policies
}

output "envs" {
  # We want to make this as sensitive "true" but that breaks dynamic blocks
  # https://github.com/hashicorp/terraform/issues/29744
  sensitive   = false
  description = "The environment (config & secrets) parsed from massdriver.yaml"
  value       = local.envs
}

output "secrets" {
  description = "Secrets from the bundle. Note that secrets are also included in the 'envs' output, however this output will only be secrets."
  value       = local.secrets
}

output "params" {
  # We provide these as an output as its needed for passing into runtimes (helm, etc)
  # and we don't want end-developers to have to parse the write files to get them since
  # we've already done the work
  description = "Parameters provided to bundle."
  value       = local.params
}

output "connections" {
  # We provide these as an output as its needed for passing into runtimes (helm, etc)
  # and we don't want end-developers to have to parse the write files to get them since
  # we've already done the work
  description = "Connections provided to bundle."
  value       = local.connections
}
