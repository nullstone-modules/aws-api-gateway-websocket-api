variable "base_url" {
  type        = string
  description = <<EOF
The endpoints for this API Gateway forward to http routes. This is the base url for those routes.
e.g. If the base url is "https://api.acme.com", then one of the routes will be "https://api.acme.com/websocket/connect"
EOF
}
