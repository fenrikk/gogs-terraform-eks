terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.68.0" 
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
  }
  required_version = ">= 1.0"
}