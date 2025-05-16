# ======================
# Global Configuration
# ======================

variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "ap-south-1" # Default to Mumbai region
  # Note: Consider making this required in production environments
}

variable "tags" {
  description = "Common tags to be applied to all resources for better organization and cost tracking"
  type        = map(string)
  default     = {
    Terraform   = "true"  # Identifies resources managed by Terraform
    Environment = "dev"    # Environment classification (dev/stage/prod)
  }
  # Additional tags like 'Owner', 'CostCenter' can be added here
}

# ======================
# Networking Configuration
# ======================

variable "vpc_name" {
  description = "Name tag for the VPC (used for identification in AWS console)"
  type        = string
  # This should be provided by the calling module/workspace
}

variable "project_name" {
  description = "Project name used as prefix for resource naming (e.g., 'ecommerce', 'analytics')"
  type        = string
  # Important for resource naming consistency across AWS
}

variable "vpc_cidr" {
  description = "Primary CIDR block for the VPC in CIDR notation (e.g., 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16" # Default /16 provides 65,536 IP addresses
  # Note: Ensure this doesn't overlap with other networks in your organization
}

variable "availability_zones" {
  description = "List of exactly 3 Availability Zones for high availability deployment"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"] # Mumbai region AZs
  validation {
    condition     = length(var.availability_zones) == 3
    error_message = "Exactly 3 availability zones must be specified for proper high availability."
  }
  # Using 3 AZs ensures resilience against AZ failures
}

variable "availability_zones_short" {
  description = "Short codes for AZs used in resource naming (e.g., 'aza', 'azb', 'azc')"
  type        = list(string)
  default     = ["aza", "azb", "azc"]
  # These short codes are used in resource names to indicate AZ placement
}

# ======================
# Subnet Configuration
# ======================

variable "public_subnets" {
  description = "CIDR blocks for public subnets (one per AZ) that will have direct internet access via IGW"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # /24 provides 256 IPs per subnet
  # Public subnets typically host load balancers, bastion hosts, and NAT gateways
}

variable "private_subnets" {
  description = "CIDR blocks for private application subnets (one per AZ) with outbound internet via NAT"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  # Private subnets host application servers, containers, and other backend services
}

variable "database_subnets" {
  description = "CIDR blocks for isolated database subnets (one per AZ) with no internet access"
  type        = list(string)
  default     = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
  # Database subnets have the most restrictive security groups
}

variable "create_database_subnet_group" {
  description = "Whether to create a database subnet group for RDS/Aurora (required for most database services)"
  type        = bool
  default     = true
  # Set to false if you're managing database subnet groups separately
}

# ======================
# Bastion Host Configuration
# ======================

variable "bastion_ami_id" {
  description = "AMI ID for the bastion host (Amazon Linux 2 recommended for security updates)"
  type        = string
  # Example: "ami-0cca134ec43cf708f" (Amazon Linux 2 in ap-south-1)
  # Note: Consider using a hardened bastion AMI for production
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host (t3.micro is sufficient for most use cases)"
  type        = string
  default     = "t3.micro" # Burstable instance type with good cost-performance
  # For high-traffic bastions, consider t3.small or larger
}

variable "trusted_ssh_cidr" {
  description = "CIDR block(s) allowed to SSH to the bastion (e.g., your office IP or VPN range)"
  type        = string
  # Example: "203.0.113.42/32" for a specific IP
  # Security best practice: Restrict this as narrowly as possible
}

variable "key_name" {
  description = "Name of existing EC2 key pair for SSH access to the bastion host"
  type        = string
  # Key pairs should be managed securely and rotated periodically
}

variable "bastion_instance_name" {
  description = "Name tag for the bastion host instance (visible in AWS console)"
  type        = string
  default     = "bastion-host"
  # Consider including environment in the name (e.g., "prod-bastion")
}
