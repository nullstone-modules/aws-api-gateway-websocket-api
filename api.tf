resource "aws_apigatewayv2_api" "this" {
  name                         = local.resource_name
  protocol_type                = "WEBSOCKET"
  route_selection_expression   = "$request.body.action"
  api_key_selection_expression = "$request.header.x-api-key"

  tags = local.tags
}

/*
resource "aws_apigatewayv2_stage" "default" {
  api_id        = aws_apigatewayv2_api.this.id
  name          = "default"
  auto_deploy   = true

  depends_on = [aws_api_gateway_account.this]

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this.arn
    format          = "{\"requestId\":\"$context.requestId\",\"ip\":\"$context.identity.sourceIp\",\"requestTime\":\"$context.requestTime\",\"httpMethod\":\"$context.httpMethod\",\"resourcePath\":\"$context.routeKey\",\"status\":\"$context.status\",\"responseLength\":\"$context.responseLength\"}"
  }
}

resource "aws_apigatewayv2_deployment" "this" {
  api_id = aws_apigatewayv2_api.this.id

  lifecycle {
    create_before_destroy = true
  }
}
*/

resource "aws_apigatewayv2_integration" "connect-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = "${var.base_url}/websocket/connect"
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
resource "aws_apigatewayv2_route_response" "connect-response" {
  api_id             = aws_apigatewayv2_api.this.id
  route_id           = aws_apigatewayv2_route.connect-route.id
  route_response_key = "$default"
}


resource "aws_apigatewayv2_integration" "default-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = "${var.base_url}/websocket/default"
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
resource "aws_apigatewayv2_route_response" "default-response" {
  api_id             = aws_apigatewayv2_api.this.id
  route_id           = aws_apigatewayv2_route.default-route.id
  route_response_key = "$default"
}


resource "aws_apigatewayv2_integration" "disconnect-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = "${var.base_url}/websocket/disconnect"
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
resource "aws_apigatewayv2_route_response" "disconnect-response" {
  api_id             = aws_apigatewayv2_api.this.id
  route_id           = aws_apigatewayv2_route.disconnect-route.id
  route_response_key = "$default"
}


resource "aws_apigatewayv2_integration" "chat-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = "${var.base_url}/websocket/chat"
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
resource "aws_apigatewayv2_route_response" "chat-response" {
  api_id             = aws_apigatewayv2_api.this.id
  route_id           = aws_apigatewayv2_route.chat-route.id
  route_response_key = "$default"
}


resource "aws_apigatewayv2_integration" "message-integration" {
  api_id             = aws_apigatewayv2_api.this.id
  integration_type   = "HTTP_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = "${var.base_url}/websocket/message"
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
resource "aws_apigatewayv2_route_response" "message-response" {
  api_id             = aws_apigatewayv2_api.this.id
  route_id           = aws_apigatewayv2_route.message-route.id
  route_response_key = "$default"
}
