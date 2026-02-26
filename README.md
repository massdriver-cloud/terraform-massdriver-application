# Terraform Massdriver Application Module

[![Terraform Registry](https://img.shields.io/badge/Terraform%20Registry-published-blue?style=flat-square&logo=terraform)](https://registry.terraform.io/modules/massdriver-cloud/application/massdriver/latest)
[![License](https://img.shields.io/github/license/massdriver-cloud/terraform-massdriver-application?style=flat-square)](LICENSE)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%201.0-blue?style=flat-square)](https://www.terraform.io/downloads.html)

[Massdriver](https://www.massdriver.cloud) is the fastest way to build reusable self-service Terraform modules with built-in policies, documentation, and deployment pipelines. Instead of just writing code, Massdriver lets you define opinionated infrastructure components as productized modules — complete with validation, compliance checks, and a UI for developers. It’s the best way to manage self-service infrastructure without losing control of your Terraform workflows.

This Terraform module provides seamless integration with Massdriver's application deployment system. It enables your application to access Massdriver's secrets management, connection system for infrastructure data, and dynamic environment variable configuration.

## Features

- 🔐 Automatic secrets management integration
- 🔌 Infrastructure connection handling
- ⚙️ Dynamic environment variable configuration
- 📋 Policy validation and enforcement
- 🔄 Automatic YAML/JSON parsing of Massdriver bundle files

## Usage

```hcl
module "massdriver_app" {
  source = "massdriver-cloud/application/massdriver"
}

# Access your application's environment variables
output "app_envs" {
  value = module.massdriver_app.envs
}

# Access your application's secrets
output "app_secrets" {
  value = module.massdriver_app.secrets
}

# Access your application's parameters
output "app_params" {
  value = module.massdriver_app.params
}

# Access your application's connections
output "app_connections" {
  value = module.massdriver_app.connections
}

# Access your application's policies
output "app_policies" {
  value = module.massdriver_app.policies
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| jq | ~> 0.2 |

## Inputs

This module automatically reads the following files from your Massdriver bundle:
- `/massdriver/bundle/massdriver.yaml`
- `${path.root}/_connections.auto.tfvars.json`
- `${path.root}/_params.auto.tfvars.json`
- `/massdriver/secrets.json`
- `/massdriver/envs.json`

## Outputs

| Name | Description |
|------|-------------|
| envs | The environment (config & secrets) parsed from massdriver.yaml |
| secrets | Secrets from the bundle |
| params | Parameters provided to bundle |
| connections | Connections provided to bundle |
| policies | The policies parsed from massdriver.yaml |

## Development

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) ~> 1.0
- [pre-commit](https://pre-commit.com/#install)

### Setup

1. Install pre-commit hooks:
```bash
pre-commit install
```

2. Run pre-commit checks:
```bash
pre-commit run -a
```

## License

This project is licensed under the MPL License - see the [LICENSE](LICENSE) file for details.
