# Security Automation Suite - Main Terraform Configuration

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Backend configuration for remote state
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "security-automation/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "Security Automation Suite"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Local values
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
  
  # Common tags
  common_tags = {
    Project     = "Security Automation Suite"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Core security automation modules
module "security_hub" {
  source = "./modules/security-hub"
  
  environment = var.environment
  tags        = local.common_tags
}

module "compliance_scanning" {
  source = "./modules/compliance-scanning"
  
  environment = var.environment
  tags        = local.common_tags
}

module "vault_integration" {
  source = "./modules/vault-integration"
  
  environment = var.environment
  tags        = local.common_tags
}

module "container_security" {
  source = "./modules/container-security"
  
  environment = var.environment
  tags        = local.common_tags
}

module "evidence_collection" {
  source = "./modules/evidence-collection"
  
  environment = var.environment
  tags        = local.common_tags
}