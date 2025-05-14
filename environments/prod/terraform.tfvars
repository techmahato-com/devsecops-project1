vpc_name     = "TM-DevSecOps-PROD-VPC"
project_name = "TM-DevSecOps"
vpc_cidr     = "10.195.0.0/16"

public_subnets = [
  "10.195.1.0/24",
  "10.195.3.0/24",
  "10.195.5.0/24"
]

private_subnets = [
  "10.195.2.0/24",
  "10.195.4.0/24",
  "10.195.6.0/24"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]

availability_zones_short = ["a", "b", "c"]
region = "ap-south-1"

tags = {
  Environment = "production"
  Project     = "TM-DevSecOps"
  Terraform   = "true"
}

#trusted_ssh_cidr        = "0.0.0.0/0" # change this to your IP in prod
#bastion_ami_id          = "ami-0abcdef1234567890"
#bastion_instance_type   = "t3.micro"
#key_name                = "my-key-pair"
#bastion_instance_name   = "TM-DevSecOps-bastion"

