variable bucket_name {
  type        = string
  description = "S3 bukcet name"
}

variable retention_period_ia {
  type        = number
  description = "Retention period for Infrequently Accessed"
  default = 30
}

variable retention_period_glacier {
  type        = number
  description = "Retention period for Glacier"
  default = 60
}

variable enable_kms {
  description = "Do you what AWS-KMS encryption for s3 objects"
  type = bool
  default = false
}

variable bucket_policy {
  type        = string
  description = "A valid bucket policy JSON document"
}

variable mymap {
  type        = map
  default     = {
      Key1 = "STANDARD_IA"
      Key2 = "GLACIER"
  }
}