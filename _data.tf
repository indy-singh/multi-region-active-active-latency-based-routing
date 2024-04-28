data "aws_cloudfront_origin_request_policy" "all_viewer_except_host_header" {
  provider = aws.virginia
  name     = "Managed-AllViewerExceptHostHeader"
}

data "aws_cloudfront_origin_request_policy" "all_viewer" {
  provider = aws.virginia
  name     = "Managed-AllViewer"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  provider = aws.virginia
  name     = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  provider = aws.virginia
  name     = "Managed-CachingOptimized"
}