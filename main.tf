terraform {
  required_providers {
    spacelift = {
      source  = "spacelift.io/spacelift-io/spacelift"
      version = "1.19.0"
    }
  }
}

provider "spacelift" {}
