## =============================================================================
#  IAM user for CloudOut operations                                            #
## =============================================================================
# Provides the AWS account ID to other resources
# Interpolate: data.aws_caller_identity.current.account_id
data "aws_caller_identity" "current" {}

# Create user and access keys
# Account scope is limited by IAM policies
resource "aws_iam_user" "mabel-iam-user" {
  name = "mabel-iam-svc-use1"
}

resource "aws_iam_access_key" "mabel-iam-user-key" {
  user = aws_iam_user.mabel-iam-user.name
}

# Create IAM policy
# This is used for archving data to S3
resource "aws_iam_policy" "mabel-cloud-out" {
  name = "mabel-cloud-out-policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "RubrikCloudOutS3All",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        },
        {
            "Sid": "RubrikCloudOutS3Restricted",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:ListAllMyBuckets",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:RestoreObject"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# Attach policy to the IAM account
resource "aws_iam_user_policy_attachment" "mabel-cloud-out" {
    user       = aws_iam_user.mabel-iam-user.name
    policy_arn = aws_iam_policy.mabel-cloud-out.arn
}

# This policy is used to instantiate Bolt instances
# Bolt is used for archive consolidation and CloudOn conversions
resource "aws_iam_policy" "mabel-cloud-on" {
  name = "mabel-cloud-on-policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid":  "RubrikCloudOnv50",
            "Effect": "Allow",
            "Action": [
              "kms:Encrypt",
              "kms:Decrypt",
              "kms:GenerateDataKeyWithoutPlaintext",
              "kms:GenerateDataKey",
              "kms:DescribeKey",
              "ec2:DescribeInstances",
              "ec2:CreateKeyPair",
              "ec2:CreateImage",
              "ec2:CopyImage",
              "ec2:DescribeSnapshots",
              "ec2:DeleteVolume",
              "ec2:StartInstances",
              "ec2:DescribeVolumes",
              "ec2:DescribeExportTasks",
              "ec2:DescribeAccountAttributes",
              "ec2:ImportImage",
              "ec2:DescribeKeyPairs",
              "ec2:DetachVolume",
              "ec2:CancelExportTask",
              "ec2:CreateTags",
              "ec2:RunInstances",
              "ec2:StopInstances",
              "ec2:CreateVolume",
              "ec2:DescribeImportSnapshotTasks",
              "ec2:DescribeSubnets",
              "ec2:AttachVolume",
              "ec2:DeregisterImage",
              "ec2:ImportVolume",
              "ec2:DeleteSnapshot",
              "ec2:DeleteTags",
              "ec2:DescribeInstanceAttribute",
              "ec2:DescribeAvailabilityZones",
              "ec2:CreateSnapshot",
              "ec2:ModifyInstanceAttribute",
              "ec2:DescribeInstanceStatus",
              "ec2:CreateInstanceExportTask",
              "ec2:TerminateInstances",
              "ec2:ImportInstance",
              "s3:CreateBucket",
              "s3:ListAllMyBuckets",
              "ec2:DescribeTags",
              "ec2:CancelConversionTask",
              "ec2:ImportSnapshot",
              "ec2:DescribeImportImageTasks",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeImages",
              "ec2:DescribeVpcs",
              "ec2:CancelImportTask",
              "ec2:DescribeConversionTasks"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# Attach policy to the IAM account
resource "aws_iam_user_policy_attachment" "mabel-cloud-on" {
    user       = aws_iam_user.mabel-iam-user.name
    policy_arn = aws_iam_policy.mabel-cloud-on.arn
}

## =============================================================================
#  KMS Key for encrypting data in S3 Bucket                                    #
## =============================================================================
resource "aws_kms_key" "mabel-kms" {
  description   = "KMS key for Rubrik CloudOut and CloudOn"
  tags = {
    Name        = "mabel-kms-s3-use1"
    environment = var.aws_environment_name
    managed-by  = "Terraform"
    rubrik-cdm  = var.aws_rubrik_cdm
    use-case    = "rubrik-archive"
  }

  policy = <<EOF
{
    "Id": "key-consolepolicy-3",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.mabel-iam-user.name}"
                ]
            },
            "Action": [
                "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource",
                "kms:ScheduleKeyDeletion",
                "kms:CancelKeyDeletion"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.mabel-iam-user.name}"
                ]
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# Create KMS alias to further abstract away underlying encryption key
resource "aws_kms_alias" "mabel-kms-alias" {
  target_key_id = aws_kms_key.mabel-kms.key_id
  name          = "alias/mabel-kms-s3-use1"
}

## =============================================================================
#  Create S3 bucket for archive and specify encryption key                     #
## =============================================================================
# Create bucket for logging
resource "aws_s3_bucket" "mabel-log-use1-c" {
  bucket = "mabel-log-use1-c"
  acl    = "log-delivery-write"

  tags = {
    Name        = "mabel-log-use1-c"
    environment = var.aws_environment_name
    managed-by  = "Terraform"
    rubrik-cdm  = var.aws_rubrik_cdm
    use-case    = "rubrik-archive-cloudtrail"
  }

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::mabel-log-use1-c"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::mabel-log-use1-c/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
EOF
}

# Provides additional layers of security to block all public access to the bucket
resource "aws_s3_bucket_public_access_block" "mabel-log-use1-c" {
  bucket                  = aws_s3_bucket.mabel-log-use1-c.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
  
# Create bucket for archive
resource "aws_s3_bucket" "mabel-s3-use1-c" {
  bucket = "mabel-s3-use1-c"
  acl    = "private"
  versioning {
    enabled = true
  }

  tags = {
    Name        = "mabel-s3-use1-c"
    environment = var.aws_environment_name
    managed-by  = "Terraform"
    rubrik-cdm  = var.aws_rubrik_cdm
    use-case    = "rubrik-archive"
  }

  logging {
    target_bucket = aws_s3_bucket.mabel-log-use1-c.id
    target_prefix = "log/"
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mabel-kms.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Provides additional layers of security to block all public access to the bucket
resource "aws_s3_bucket_public_access_block" "mabel-s3-use1-c" {
  bucket                  = aws_s3_bucket.mabel-s3-use1-c.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## =============================================================================
#  Use CloudTrail to log S3 bucket events                                      #
## =============================================================================
data "aws_s3_bucket" "mabel-s3-use1-c" {
  bucket = aws_s3_bucket.mabel-s3-use1-c.id
}

resource "aws_cloudtrail" "mabel-cloudtrail-use1-c" {
  name                          = "mabel-cloudtrail-use1-c"
  s3_bucket_name                = aws_s3_bucket.mabel-log-use1-c.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false

  event_selector {
    read_write_type           = "All"
    include_management_events = true

  data_resource {
    type = "AWS::S3::Object"
    values = ["${data.aws_s3_bucket.mabel-s3-use1-c.arn}/"]
    }
  }
}

## =============================================================================
#  Security Group for Bolt (archive consolidation)                             #
## =============================================================================
resource "aws_security_group" "mabel-bolt-sg-use1-c" {
  name                = "mabel-bolt-sg-use1-c"
  description         = "Security group to allow access from lab to Bolt"
  vpc_id              = var.aws_vpc

  ingress {
    from_port   = 2002
    to_port     = 2002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow lab to Bolt port 2002"
  }

  egress {
    from_port   = 7780
    to_port     = 7780
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow lab to Bolt port 7780"
  }

    tags = {
    Name        = "mabel-bolt-sg-use1-c"
    environment = var.aws_environment_name
    managed-by  = "Terraform"
    rubrik-cdm  = var.aws_rubrik_cdm
    use-case    = "rubrik-bolt"
  }
}
