terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"   # <-- aspas fechando
    }
  }
  required_version = ">= 1.5.0"  # <-- aspas fechando
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
