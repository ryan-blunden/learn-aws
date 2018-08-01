provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "random_string" "token" {
  length = 8
  upper = false
  special = false
}

# ------------------------------------------
# IAM POLICY AND ROLE
# ------------------------------------------

resource "aws_iam_policy" "iam_policy" {
  name        = "meme_lambda_policy"
  path        = "/"
  description = "Meme emailer to access Dynamo, S3, and SES"

  policy = "${file("resources/iam-policy-meme-emailer.json")}"
}

resource "aws_iam_role" "iam_role" {
  name = "meme-emailer-role"

  assume_role_policy = "${file("resources/iam-policy-lambda-assume-role.json")}"
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = "${aws_iam_role.iam_role.name}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}

# ------------------------------------------
# S3 BUCKET
# ------------------------------------------

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.s3_bucket_name}-${random_string.token.result}"
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.s3_bucket_name}-${random_string.token.result}/*"
        }
    ]
}
EOF

  website {
    index_document = "index.html"
  }
}

# ------------------------------------------
# DYNAMODB TABLE
# ------------------------------------------
resource "aws_dynamodb_table" "meme-table" {
  name           = "${var.table_name}-${random_string.token.result}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }


  stream_enabled = true
  stream_view_type = "NEW_IMAGE"
}

# ------------------------------------------
# LAMBDA FUNCTION
# ------------------------------------------

resource "aws_lambda_function" "meme_emailer" {
  filename         = "lambda_function.zip"
  function_name    = "${var.lambda_function_name}-${random_string.token.result}"
  role             = "${aws_iam_role.iam_role.arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.6"
  source_code_hash = "${base64sha256(file("lambda_function.zip"))}"

  environment {
    variables = {
      BUCKET = "${aws_s3_bucket.bucket.id}",
      IMAGE_BASE_URL = "http://${aws_s3_bucket.bucket.website_endpoint}",
      RECIPIENT = "${var.recipient_email}",
      TABLE = "${aws_dynamodb_table.meme-table.id}"
    }
  }
}

resource "aws_lambda_event_source_mapping" "meme_event_source" {
  batch_size        = 100
  event_source_arn  = "${aws_dynamodb_table.meme-table.stream_arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.meme_emailer.arn}"
  starting_position = "LATEST"
}