## =============================================================================
#  README - Using Terraform to Provision CloudOut to AWS Resources             #
## =============================================================================
# CloudOut to AWS S3
Terraform code sample for CloudOut resource configuration
_Use at your own risk._

## Using the Sample
The resources should be configured in the following order:

1. AWS configuration (consisting of IAM user, IAM policies, KMS CMK, S3 bucket, SG for Bolt)
2. Rubrik CloudOut
3. Rubrik CloudOn (to specify VPC settings for Bolt to use during archive consolidation)

The AWS configuration will output the following: 
* KMS ID required for step 2
* Security Group ID provisioned for Bolt in step 3