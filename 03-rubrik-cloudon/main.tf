## =============================================================================
#  Configure S3 as Archive Location                                            #
## =============================================================================
resource "rubrik_aws_s3_cloudon" "mabel-s3-use1-c" {
  archive_name      = var.rubrik_archive_name
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
}