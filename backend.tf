terraform {
  backend "s3" {
    bucket         = "tm-devsecops-project1"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks-devsecops-project1"
    encrypt        = true
  }
}
