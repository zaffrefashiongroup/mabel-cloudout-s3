## =============================================================================
#  Variables - Authentication                                                  #
## =============================================================================
variable "aws_access_key" {
    type        = string
    description = "Access key authorized for this action"
}

variable "aws_secret_key" {
    type        = string
    description = "Secret key authorized for this action"
}

## =============================================================================
#  Variables - Location                                                        #
## =============================================================================
variable "aws_region" {
    type        = string
    description = "Region to create S3 bucket"
    default = "us-west-1"
}

## =============================================================================
#  Variables - Network                                                        #
## =============================================================================
variable "aws_vpc" {
    type        = string
    description = "VPC to connect Security Group"
}

## =============================================================================
#  Variables - Tags                                                            #
## =============================================================================
variable "aws_environment_name" {
    type        = string
    description = "Tag for Environment"
}

variable "aws_rubrik_cdm" {
    type        = string
    description = "Tag for affiliated Rubrik cluster"
}