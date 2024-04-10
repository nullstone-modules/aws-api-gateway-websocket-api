resource "aws_apigatewayv2_api" "this" {
  name                         = local.resource_name
  protocol_type                = "WEBSOCKET"
  route_selection_expression   = "$request.body.action"
  api_key_selection_expression = "$request.header.x-api-key"

  tags = local.tags
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.this.id
  name   = "default"

  tags = local.tags
}

resource "aws_apigatewayv2_integration" "connect-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP"
  integration_method = "POST"
  integration_uri    = "https://${local.subdomain_name}/${var.path}/websocket/connect"
}
resource "aws_apigatewayv2_integration_response" "connect-response" {
  api_id                        = aws_apigatewayv2_api.this.id
  integration_id                = aws_apigatewayv2_integration.connect-integration.id
  integration_response_key      = "$default"
  template_selection_expression = "200"
}
resource "aws_apigatewayv2_route" "connect-route" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.connect-integration.id}"
}


resource "aws_apigatewayv2_integration" "default-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP"
  integration_method = "POST"
  integration_uri    = "https://${local.subdomain_name}/${var.path}/websocket/default"
}
resource "aws_apigatewayv2_integration_response" "default-response" {
  api_id                        = aws_apigatewayv2_api.this.id
  integration_id                = aws_apigatewayv2_integration.default-integration.id
  integration_response_key      = "$default"
  template_selection_expression = "200"
}
resource "aws_apigatewayv2_route" "default-route" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.default-integration.id}"
}


resource "aws_apigatewayv2_integration" "disconnect-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP"
  integration_method = "POST"
  integration_uri    = "https://${local.subdomain_name}/${var.path}/websocket/disconnect"
}
resource "aws_apigatewayv2_integration_response" "disconnect-response" {
  api_id                        = aws_apigatewayv2_api.this.id
  integration_id                = aws_apigatewayv2_integration.disconnect-integration.id
  integration_response_key      = "$default"
  template_selection_expression = "200"
}
resource "aws_apigatewayv2_route" "disconnect-route" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.disconnect-integration.id}"
}


resource "aws_apigatewayv2_integration" "chat-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP"
  integration_method = "POST"
  integration_uri    = "https://${local.subdomain_name}/${var.path}/websocket/chat"
}
resource "aws_apigatewayv2_integration_response" "chat-response" {
  api_id                        = aws_apigatewayv2_api.this.id
  integration_id                = aws_apigatewayv2_integration.chat-integration.id
  integration_response_key      = "$default"
  template_selection_expression = "200"
}
resource "aws_apigatewayv2_route" "chat-route" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "chat"
  target    = "integrations/${aws_apigatewayv2_integration.chat-integration.id}"
}


resource "aws_apigatewayv2_integration" "message-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP"
  integration_method = "POST"
  integration_uri    = "https://${local.subdomain_name}/${var.path}/websocket/message"
}
resource "aws_apigatewayv2_integration_response" "message-response" {
  api_id                        = aws_apigatewayv2_api.this.id
  integration_id                = aws_apigatewayv2_integration.message-integration.id
  integration_response_key      = "$default"
  template_selection_expression = "200"
}
resource "aws_apigatewayv2_route" "message-route" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "message"
  target    = "integrations/${aws_apigatewayv2_integration.message-integration.id}"
}
