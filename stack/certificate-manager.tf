resource "aws_acm_certificate" "certificate" {
  provider                  = aws.region
  domain_name               = "example.com"
  subject_alternative_names = ["*.example.com", "*.demo.example.com"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "validation" {
  provider                = aws.region
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_records : record.fqdn]
}