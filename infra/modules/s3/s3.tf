module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.application_bucket_name
  acl    = "private"

  block_public_acls = true
  block_public_policy = true

  versioning = {
    enabled = true
  }

  

}