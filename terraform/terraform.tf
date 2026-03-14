# terraform config 
terraform {
  required_providers {
    aws = { # aws config
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0" # terraform core version
}