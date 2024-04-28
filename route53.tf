resource "aws_route53_record" "live_customer_store" {
  provider = aws.virginia
  zone_id  = data.aws_route53_zone.example_com.zone_id
  name     = "*.example.com"
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.hello_world_store.domain_name
    zone_id                = aws_cloudfront_distribution.hello_world_store.hosted_zone_id
    evaluate_target_health = false
  }
}