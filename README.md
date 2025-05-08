# Terraform Massdriver Application Module

[![Terraform Registry](https://img.shields.io/github/v/release/massdriver-cloud/terraform-massdriver-application?label=Terraform%20Registry&style=flat-square)](https://registry.terraform.io/modules/massdriver-cloud/massdriver-application)
[![License](https://img.shields.io/github/license/massdriver-cloud/terraform-massdriver-application?style=flat-square)](LICENSE)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%201.0-blue?style=flat-square)](https://www.terraform.io/downloads.html)

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
  source = "massdriver-cloud/massdriver-application/terraform"
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
