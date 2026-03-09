variable "aws_region" {
  description = "AWS region for the lab deployment"
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix used for AWS resource names"
  type        = string
  default     = "datadog-lab"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

variable "key_name" {
  description = "Optional existing EC2 key pair name for SSH access"
  type        = string
  default     = null
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH to the instance"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  description = "CIDR allowed to access the lab application"
  type        = string
  default     = "0.0.0.0/0"
}

variable "datadog_api_key" {
  description = "Datadog API key passed to the Datadog Agent"
  type        = string
  sensitive   = true
}

variable "vpc_cidr" {
  description = "CIDR block for the dedicated lab VPC"
  type        = string
  default     = "10.99.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet used by the EC2 instance"
  type        = string
  default     = "10.99.1.0/24"
}

variable "vpc_name" {
  description = "Name tag of the existing VPC"
  type        = string
  default     = "datadog-lab1-vpc"
}