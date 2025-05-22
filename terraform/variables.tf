# Security Automation Suite - Terraform Variables

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Name of the security automation project"
  type        = string
  default     = "security-automation-suite"
}

variable "vpc_id" {
  description = "VPC ID for security automation resources"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Subnet IDs for security automation resources"
  type        = list(string)
  default     = []
}

variable "enable_security_hub" {
  description = "Enable AWS Security Hub"
  type        = bool
  default     = true
}

variable "enable_guardduty" {
  description = "Enable AWS GuardDuty"
  type        = bool
  default     = true
}

variable "enable_config" {
  description = "Enable AWS Config"
  type        = bool
  default     = true
}

variable "compliance_standards" {
  description = "List of compliance standards to enable"
  type        = list(string)
  default     = ["SOX", "PCI-DSS", "GDPR", "FINRA"]
}

variable "notification_email" {
  description = "Email address for security notifications"
  type        = string
  default     = null
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 365
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}