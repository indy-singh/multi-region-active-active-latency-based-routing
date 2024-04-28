resource "aws_apigatewayv2_api" "hello_world" {
  provider                     = aws.region
  name                         = "hello_world"
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = false
}

resource "aws_apigatewayv2_stage" "default" {
  provider    = aws.region
  api_id      = aws_apigatewayv2_api.hello_world.id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    detailed_metrics_enabled = false
    throttling_burst_limit   = 5000
    throttling_rate_limit    = 10000
  }
}

resource "aws_apigatewayv2_route" "default" {
  provider  = aws.region
  api_id    = aws_apigatewayv2_api.hello_world.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.default.id}"
}

resource "aws_apigatewayv2_integration" "default" {
  provider         = aws.region
  depends_on       = [aws_lambda_function.function]
  api_id           = aws_apigatewayv2_api.hello_world.id
  integration_type = "AWS_PROXY"

  integration_method     = "GET"
  integration_uri        = aws_lambda_function.function.arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_domain_name" "example" {
  provider    = aws.region
  domain_name = "multi-region-active-active-latency-based-routing.example.com"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate_validation.validation.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "example" {
  provider    = aws.region
  api_id      = aws_apigatewayv2_api.hello_world.id
  domain_name = aws_apigatewayv2_domain_name.example.id
  stage       = aws_apigatewayv2_stage.default.id
}