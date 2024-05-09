output "websocket_url" {
  value = aws_apigatewayv2_stage.default.invoke_url
}

output "websocket_api_arn" {
  value = aws_apigatewayv2_api.this.arn
}

output "websocket_api_id" {
  value = aws_apigatewayv2_api.this.id
}
