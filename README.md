# devsecops-project1
DevSecOps on AWS Project 1 with EKS Cluster

1. Create an S3 Bucket for Terraform State: Use the AWS Console or CLI to create an S3 bucket. This will store your terraform.tfstate.
aws s3api create-bucket \
  --bucket tm-devsecops-project1 \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

2. To enable versioning:
aws s3api put-bucket-versioning \
  --bucket tm-devsecops-project1 \
  --versioning-configuration Status=Enabled

3. Create a DynamoDB Table for State Locking: Terraform uses this table to implement a locking mechanism and avoid concurrent state changes.
aws dynamodb create-table \
  --table-name terraform-locks-devsecops-project1 \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

4. Configure backend.tf in Terraform Code

5. Initialize Terraform Backend
cd environments/prod
terraform init





