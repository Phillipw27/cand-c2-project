terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.27"
        }
    }

    required_version = ">= 0.14.9"
}

provider "aws" {
    region  =    var.aws_region
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "logging_for_lambda" {
  name = "lambda_logging"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:PutLogEvents",
            "Resource": "arn:aws:logs:*:*:log-group:*:log-stream:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Resource": "arn:aws:logs:*:*:log-group:*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.logging_for_lambda.arn
}


resource "aws_lambda_function" "test_lambda" {
    filename = "greet_lambda.py.zip"
    function_name = "greet_lambda"
    role = aws_iam_role.iam_for_lambda.arn
    handler = "greet_lambda.lambda_handler"
    runtime = "python3.8"

    environment {
      variables = {
        greeting = "Hello from Terraform"
      }
    }
}