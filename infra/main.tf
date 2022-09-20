module "TestBucket" {
    source = "./modules/s3"

    application_bucket_name = var.application_bucket_name
}