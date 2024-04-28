data "aws_iam_role" "lambda_execution_role" {
  provider = aws.region
  name     = "GenericLambdaExecutionRole"
}

data "aws_route53_zone" "example_com" {
  provider = aws.region
  name     = "example.com"
}

data "aws_region" "current" {
  provider = aws.region
}