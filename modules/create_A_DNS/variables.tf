variable "api_token" {}
variable "zone_id" {}
variable "name" {}
variable "value" {}
variable "domain" {}
variable "tls" { default = false }
variable "login_limit" { default = false }
variable "load_balancer_monitor" { default = false }
variable "load_balancer_pool" { default = false }