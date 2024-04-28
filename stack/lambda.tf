data "archive_file" "handler" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/index.zip"
}

resource "aws_lambda_function" "function" {
  provider         = aws.region
  function_name    = "hello-world"
  filename         = data.archive_file.handler.output_path
  source_code_hash = data.archive_file.handler.output_base64sha256
  role             = data.aws_iam_role.lambda_execution_role.arn
  handler          = "index.handler"
  memory_size      = 128
  runtime          = "nodejs20.x"
  timeout          = 3
  architectures    = ["arm64"]

  environment {
    variables = {
      NODE_ENV = "production"
    }
  }

  logging_config {
    log_format            = "JSON"
    application_log_level = "INFO"
    system_log_level      = "INFO"
  }
}

resource "aws_lambda_permission" "permission" {
  provider      = aws.region
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "apigateway.amazonaws.com"
}