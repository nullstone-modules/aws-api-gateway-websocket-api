resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/apigateway/${local.resource_name}"
  retention_in_days = 7
  kms_key_id        = aws_kms_key.this.arn
  tags              = local.tags
}

resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.api-gateway-cloudwatch-role.arn
}

resource "aws_iam_role" "api-gateway-cloudwatch-role" {
  name = local.resource_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.api-gateway-cloudwatch-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}