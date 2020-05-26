## =============================================================================
#  Configure S3 as Archive Location                                            #
## =============================================================================
resource "rubrik_aws_s3_cloudout" "mabel-s3-use1-c" {
  aws_region        = var.aws_region
  aws_bucket        = var.aws_bucket
  aws_access_key    = var.aws_access_key
  aws_secret_key    = var.aws_secret_key
  storage_class     = var.aws_storage_class
  archive_name      = var.rubrik_archive_name
  kms_master_key_id = var.aws_kms_key
}