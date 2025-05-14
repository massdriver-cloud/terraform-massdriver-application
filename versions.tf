terraform {
  required_version = "~> 1.0"
  required_providers {
    jq = {
      source  = "massdriver-cloud/jq"
      version = "~> 0.2"
    }
  }
}
