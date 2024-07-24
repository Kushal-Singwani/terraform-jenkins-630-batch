terraform {
  # apply aws provider in terraform 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }
  # apply s3 backend on aws account 
  backend "s3" {
    bucket = "terraform-s3-class-630"
    key    = "statecollection"
    region = "ap-south-1"
  }
}

provider "aws" {
  # Configuration options for provider setup 
  region = var.aws_provider_region
}

module "jenkins-class-630-dev" {
  source = "./modules/dev"
  # define dev modules variables values in terraform
  name_project = "jenkins-terraform-dev"
  vpc_dev_cidr = "10.10.0.0/16"
  vpc_dev_subnet_cidr = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24"]
  vpc_dev_subnet_az = ["ap-south-1a", "ap-south-1b"]
}

module "jenkins-class-630-prod" {
  source = "./modules/prod"
  vpc_prod_cidr = "10.20.0.0/16"
  vpc_prod_subnet_cidr = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24", "10.20.4.0/24"]
  vpc_prod_subnet_az = ["ap-south-1a", "ap-south-1b"]
}