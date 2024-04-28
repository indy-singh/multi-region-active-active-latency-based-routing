resource "aws_route53_record" "validation_records" {
  provider = aws.region
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example_com.zone_id
}

resource "aws_route53_record" "latency_record" {
  provider = aws.region
  name     = aws_apigatewayv2_domain_name.example.domain_name
  type     = "A"
  zone_id  = data.aws_route53_zone.example_com.zone_id

  set_identifier = data.aws_region.current.name

  alias {
    name                   = aws_apigatewayv2_domain_name.example.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.example.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = true
  }

  latency_routing_policy {
    region = data.aws_region.current.name
  }

  health_check_id = aws_route53_health_check.example.id
}

resource "aws_route53_health_check" "example" {
  fqdn             = replace(aws_apigatewayv2_api.hello_world.api_endpoint, "https://", "")
  port             = 443
  type             = "HTTPS"
  request_interval = "30"

  tags = {
    Name = "health-check-${data.aws_region.current.name}"
  }
}