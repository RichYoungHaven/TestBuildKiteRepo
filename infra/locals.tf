locals {
  default_tags = {
    Product            = var.product
    Application        = var.application
    Service            = var.service
    Environment        = var.environment
    Owner              = var.owner
    Client             = var.client
    DataClassification = var.data_classification
    TaggingStandardVersion = var.tagging_standard_version
  }
}
