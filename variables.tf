variable "path" {
  type        = string
  description = <<EOF
The path to append to the subdomain in order to form the full URL that requests will be routed to.
e.g. If the subdomain connected is for https://api.acme.com, and the path is v1, then the full URL will be https://api.acme.com/v1.
EOF
}
