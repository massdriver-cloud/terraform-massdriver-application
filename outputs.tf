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
