output "public_urls" {
  value = [aws_apigatewayv2_stage.default.invoke_url]
}
