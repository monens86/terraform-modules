terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region                  = "eu-west-1"
  version                 = "~> 2.70.0"
}

# Create S3 Bucket with AWS-KMS encryption for s3 objects and s3 policy
module modlues1 {
  source                   = "./s3"
  bucket_name              = "technical-interview-dejan-kms"
  retention_period_ia      = 30
  retention_period_glacier = 60
  enable_kms               = true
  bucket_policy            = "policy.json"
}

output module_output1 {
  value = module.modlues1.arn_s3_bucket
}

# Create S3 Bucket with s3 policy and with out encryption
module modlues2 {
  source                   = "./s3"
  bucket_name              = "technical-interview-dejan-nokms"
  retention_period_ia      = 30
  retention_period_glacier = 60
  enable_kms               = false
  bucket_policy            = "policy.json"
}

output module_output2 {
  value = module.modlues2.arn_s3_bucket
}