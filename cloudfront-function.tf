resource "aws_cloudfront_function" "decorate_viewer_request" {
  provider = aws.virginia
  name     = "decorate-viewer-request-hello-world"
  runtime  = "cloudfront-js-2.0"
  code     = file("${path.module}/decorate-viewer-request.js")
}