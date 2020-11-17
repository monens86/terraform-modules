resource "aws_kms_key" "s3_key" {
  count = var.enable_kms == true ? 1 : 0
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  }

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  policy = templatefile("${path.module}/${var.bucket_policy}", { BUCKETNAME = var.bucket_name})
  
  lifecycle_rule {
    id      = "Archive"
    enabled = true

    transition {
      days          = var.retention_period_ia
      storage_class = var.mymap["Key1"]
    }

    transition {
      days          = var.retention_period_glacier
      storage_class = var.mymap["Key2"]
    }
  }
  
  dynamic "server_side_encryption_configuration" {
    for_each = var.enable_kms ? [""] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = aws_kms_key.s3_key[0].arn
          sse_algorithm     = "aws:kms"
      }
    }
    } 
  }
}
