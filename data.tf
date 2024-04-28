data "aws_route53_zone" "example_com" {
  provider = aws.virginia
  name     = "example.com"
}