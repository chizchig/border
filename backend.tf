terraform {
  backend "remote" {
    organization = "the_hub"
    workspaces {
      name = "border"
    }
    # Token for authentication
    hostname = "app.terraform.io"
    token    = kCz49yyin48gHg.atlasv1.sBcstTVraAFuhYF4tJjSfbspqsVYCetWPQDbyKh54dA6J5FTal0XJVioU485T5s6vjc
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
    # skip_credentials_validation = true
  }
}
