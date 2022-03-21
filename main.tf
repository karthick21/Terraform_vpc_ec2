terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "tmsdevops5makeichyk"
    key = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "lock-makeichyk"
    access_key = "AKIAT4YIBCGZMOB6SR63"
    secret_key = "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"
  }
}

provider "aws" {
  region = "eu-central-1"
  access_key = "AKIAT4YIBCGZMOB6SR63"
  secret_key = "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"
}
#pipe test7