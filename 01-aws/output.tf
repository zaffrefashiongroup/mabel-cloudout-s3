## =============================================================================
#  Outputs required for later steps in automation workflow                     #
## =============================================================================
# Specify this in CloudOut configuration for Rubrik cluster to use KMS for data encryption
output "mabel-kms" {
  value = "${aws_kms_key.mabel-kms.id}"
}

# Specify this in CloudOn configuration for Rubrik cluster to use Bolt specific security group
output "mabel-bolt-sg-use1-c" {
  value = "${aws_security_group.mabel-bolt-sg-use1-c.id}"
}
