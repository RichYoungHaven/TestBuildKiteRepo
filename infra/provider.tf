provider "aws" {
  region  = var.region
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  region  = "us-east-1"
  alias  = "us-east-1"
}

terraform {
  backend "s3" {
    encrypt = "true"
  }
}
