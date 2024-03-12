terraform {
  backend "remote" {
    organization = "the_hub"
    workspaces {
      name = "border"
    }
    # Token for authentication
    hostname = "app.terraform.io"
    token    = "gz6WHk9kEDZdng.atlasv1.6E7FyYfi1EX7K1ZVO3mjuFn1YmG4pCAucKTOJLB8Lx3Lk0LPF44GteIQMrGatRK3ZhM"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
    # skip_credentials_validation = true
  }
}
