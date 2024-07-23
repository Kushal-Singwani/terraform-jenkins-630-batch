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
}

module "jenkins-class-630-prod" {
  source = "./modules/prod"
}