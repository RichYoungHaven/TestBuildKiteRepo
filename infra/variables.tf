variable "application" {
  type        = string
  default     = "TestBuildKiteDemoApp"
  description = "The application name"
}

variable "region" {
  default     = "eu-west-1"
  description = "The AWS region"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "DNS subject alternative names"
}

variable "validation_record_ttl" {
  type        = string
  default     = "300"
  description = "Time to live in seconds"
}


variable "application_bucket_name" {
  type        = string
  description = "Bucket Name of the bucket to be created"
}

# tags
variable "product" {
  type        = string
  default     = "BaseInfra"
  description = "The product name"
}


variable "service" {
  type        = string
  default     = "SampleService"
  description = "The service name"
}

variable "environment" {
  type        = string
  description = "The environment the resource is part of e.g. int"
}

variable "owner" {
  type        = string
  default     = "BourneLeisure"
  description = "Team (Line of business) that is responsible for this resource."
}

variable "client" {
  type        = string
  default     = "Butlins"
  description = "The client this resource/application is related to, if no related client use IRESS"
}

variable "data_classification" {
  type        = string
  default     = "Confidential"
  description = "Identify the highest classification level of any data set the application/service/stack is associated with"
}

variable "schedule" {
  type        = string
  default     = ""
  description = "Blank or the schedule to keep instances running, generally for dev/test machines that do not need to run 24/7"
}

variable "tagging_standard_version" {
  type        = string
  default     = "1"
  description = "Whenever the required tags are modified/deleted or added, we must increment the number of this to understand what has been deployed."
}

variable "team" {
  type        = string
  default     = "CCOE"
  description = "The delivery team (not squad) responsible for managing this resource"
}

variable "datadog_lambda_name" {
  type        = string
  description = "name of the datadog lambda"
}

variable "build" {
  type        = string
  description = "The BuildKite build number"
}

variable "branch" {
  type        = string
  description = "The BuildKite build branch"
}
