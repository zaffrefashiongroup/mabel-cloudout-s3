## =============================================================================
#  Variables - Rubrik Authentication                                           #
## =============================================================================
variable "node_ip" {
    type        = string
    description = "Address of Rubrik cluster node"
}

variable "username" {
    type        = string
    description = "User account authorized for Rubrik system"
}

variable "password" {
    type        = string
    description = "Password for authorized user"
}

## =============================================================================
#  Variables - AWS Authentication                                              #
## =============================================================================
variable "aws_access_key" {
    type        = string
    description = "Access key with AWS permissions"
}

variable "aws_secret_key" {
    type        = string
    description = "Secret key with AWS permissions"
}

variable "aws_kms_key" {
    type        = string
    description = "AWS managed KMS key"
}

## =============================================================================
#  Variables - AWS Configuration                                               #
## =============================================================================
variable "aws_region" {
    type        = string
    description = "Region in which S3 bucket resides"
}

variable "aws_bucket" {
    type        = string
    description = "Name of S3 bucket to use for archive"
}

variable "aws_storage_class" {
    type        = string
    description = "S3 bucket storage class"
}

## =============================================================================
#  Variables - Rubrik Configuration                                            #
## =============================================================================
variable "rubrik_archive_name" {
    type        = string
    description = "Name of Rubrik archive location"
}