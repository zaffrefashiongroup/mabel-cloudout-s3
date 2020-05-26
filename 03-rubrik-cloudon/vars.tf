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
#  Variables - Rubrik Configuration                                            #
## =============================================================================
variable "rubrik_archive_name" {
    type        = string
    description = "Name of Rubrik cluster archive location"
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

## =============================================================================
#  Variables - AWS Configuration                                               #
## =============================================================================
variable "aws_region" {
    type        = string
    description = "Region in which S3 bucket resides"
}

variable "aws_vpc_id" {
    type        = string
    description = "VPC for Bolt"  
}

variable "aws_subnet_id" {
    type        = string
    description = "Subnet for Bolt"  
}

variable "aws_security_group_id" {
    type        = string
    description = "SG for Bolt"  
}
