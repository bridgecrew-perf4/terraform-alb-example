# Creating policy on S3, for lb to write
resource "aws_s3_bucket_policy" "lb-bucket-policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
  "Id": "albPolicy1561031527701",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "alb1561031516716",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.bucket.arn}",
      "Principal": {
        "AWS": [
           "${var.aws_elb_arn}"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_name
  acl    = "private"

  tags = {
    Name = var.s3_name
  }
}