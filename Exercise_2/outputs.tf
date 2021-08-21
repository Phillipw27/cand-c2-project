# TODO: Define the output variable for the lambda function.
output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.test_lambda.arn
}