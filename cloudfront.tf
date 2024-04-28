resource "aws_cloudfront_distribution" "hello_world_store" {
  provider        = aws.virginia
  enabled         = true
  is_ipv6_enabled = false
  price_class     = "PriceClass_All"
  comment         = "hello-world-store"
  http_version    = "http2and3"

  origin {
    domain_name = "multi-region-active-active-latency-based-routing.example.com"
    origin_id   = "multi-region-active-active-latency-based-routing.example.com"

    connection_attempts = 3
    connection_timeout  = 10

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = "REPLACE_WITH_YOUR_CERT" # TODO
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  aliases = ["*.example.com"]

  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD"]
    cached_methods             = ["GET", "HEAD"]
    target_origin_id           = "multi-region-active-active-latency-based-routing.example.com"
    viewer_protocol_policy     = "redirect-to-https"
    cache_policy_id            = aws_cloudfront_cache_policy.live_customer_store.id
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.all_viewer_except_host_header.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.live_customer_store.id
    compress                   = true

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.decorate_viewer_request.arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_cache_policy" "live_customer_store" {
  name = "live-customer-store-hello-world"

  min_ttl     = 0
  default_ttl = 0
  max_ttl     = 60 * 11 # 11 minutes

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true

    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Origin"]
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }

  provider = aws.virginia
}

resource "aws_cloudfront_response_headers_policy" "live_customer_store" {
  name = "live-customer-store-hello-world"

  custom_headers_config {
    items {
      header   = "Cache-Control"
      override = false
      value    = "x-placeholder"
    }
  }

  provider = aws.virginia
}