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
