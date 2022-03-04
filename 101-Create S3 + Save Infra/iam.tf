
data "aws_iam_policy_document" "ec2-assume-role-policy" {
statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role_s3_access" {
  name = "iam-role-${var.env}-${var.appname}-s3-access"
  assume_role_policy = data.aws_iam_policy_document.ec2-assume-role-policy.json
}

resource "aws_iam_user" "iam_user_s3_access" {
  name = "iam-user-${var.env}-${var.appname}-s3-access"
}

resource "aws_iam_access_key" "access_key_user_s3_access" {
  user    = aws_iam_user.iam_user_s3_access.name
}

resource "aws_iam_policy" "iam_policy_s3_access" {
  name = "iam_policy_${var.env}_${var.appname}_s3_access"
  depends_on = [aws_s3_bucket.s3_cicd]
  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObjectVersion",
                "s3:ListBucketVersions",
                "s3:RestoreObject",
                "s3:ListBucket",
                "s3:ReplicateObject",
                "s3:DeleteObject",
                "s3:ListBucketMultipartUploads",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:PutBucketWebsite",
                "s3:ReplicateDelete"
            ],
            "Resource": [
                "${aws_s3_bucket.s3_cicd.arn}",
                "${aws_s3_bucket.s3_cicd.arn}/*",
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:ListJobs",
                "s3:ListStorageLensConfigurations",
                "s3:ListAllMyBuckets",
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "role_attachement_cicd" {
  role       = aws_iam_role.iam_role_s3_access.name
  policy_arn = aws_iam_policy.iam_policy_s3_access.arn
}

resource "aws_iam_user_policy_attachment" "user_attachement_cicd" {
  user       = aws_iam_user.iam_user_s3_access.name
  policy_arn = aws_iam_policy.iam_policy_s3_access.arn
}
