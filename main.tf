provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# Initialize Remote Backend
resource "aws_s3_bucket" "bucket" {
    bucket = var.s3_name
    lifecycle {
    prevent_destroy = true
  }
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

resource "aws_s3_bucket_versioning" "s3_ver" {
    bucket = aws_s3_bucket.bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform-lock" {
    name           = var.dynamodb_table_name
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}

terraform {
  backend "s3" {
    bucket         = "backend-gaser-43"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
    encrypt        = true
  }
}
module "vpc" {
    source = "./vpc"
}

module "security_group" {
    source = "./security_group"
    vpc_id = module.vpc.vpc_id
}
module "instances" {
    source = "./instances"
    vpc_id = module.vpc.vpc_id
    private_subnet_id = module.vpc.private_subnet_id
    public_subnet_id = module.vpc.public_subnet_id
    security_group_id = module.security_group.security_group_id
    lb_dns = module.loadbalancer.lb_dns[1]
}

module "loadbalancer" {
    source = "./loadbalancer"
    private_subnet_id = module.vpc.private_subnet_id
    public_subnet_id = module.vpc.public_subnet_id
    security_group_id = module.security_group.security_group_id
    vpc_id = module.vpc.vpc_id
    public_instances = module.instances.public_instance_ids
    private_instances = module.instances.private_instance_ids
}

