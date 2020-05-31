# README - Using Terraform to Provision CloudOut to AWS Resources
================================================================================
# CloudOut to Amazon S3
Terraform code sample for CloudOut to Amazon S3 resource configuration
_Use at your own risk._

## :white_check_mark: Prerequisites

There are a few services you'll need in order to get this project off the ground:

* AWS Account with permissions to create resources
* Rubrik cluster to configure for CloudOut
* Terraform

## :blue_book: How to Use This Project

The resources should be configured in the following order:

1. AWS configuration (consisting of IAM user, IAM policies, KMS CMK, S3 bucket, SG for Bolt)
2. Rubrik CloudOut
3. Rubrik CloudOn (to specify VPC settings for Bolt to use during archive consolidation)

The AWS configuration will output the following: 
* KMS ID required for step 2
* Security Group ID provisioned for Bolt in step 3

## :pushpin: License

* [MIT License](LICENSE)
