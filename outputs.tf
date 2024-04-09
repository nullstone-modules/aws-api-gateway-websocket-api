output "public_urls" {
  value = [aws_apigatewayv2_stage.default.invoke_url]
}

output "permissions" {
  value = [
    {
      sid_prefix = "AllowGatewayAccess"
      action     = "lambda:InvokeFunction"
      principal  = "apigateway.amazonaws.com"
      source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*"
    }
  ]
}
