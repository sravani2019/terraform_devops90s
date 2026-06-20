terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.50.0"
    }
  }
 
  backend "s3" {
    bucket = "remote-state-devops90s"
    key    = "provisoner.terrafrom.state"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}


provider "aws" {
  # Configuration options
}