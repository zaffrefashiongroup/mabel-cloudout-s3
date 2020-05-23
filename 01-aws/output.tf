## =============================================================================
#  Outputs required for later steps in automation workflow                     #
## =============================================================================
# Specify this in CloudOut configuration for Rubrik cluster to use KMS for data encryption
output "nova-kms" {
  value = "${aws_kms_key.nova-kms.id}"
}

# Specify this in CloudOn configuration for Rubrik cluster to use Bolt specific security group
output "nova-bolt-sg-use1-c" {
  value = "${aws_security_group.nova-bolt-sg-use1-c.id}"
}