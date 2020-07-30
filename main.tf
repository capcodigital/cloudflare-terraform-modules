module "DNS_A" {
  source      = "./modules/create_A_DNS"
  api_token   = var.cloudflare_api_token
  email       = var.email
  api_key     = var.api_key
  zone_id     = var.cloudflare_zone_id
  name        = var.dns_name
  value       = var.dns_value
  domain      = var.domain
  tls         = var.tls
  login_limit = var.login_limit
}


# module "DNS_A_load_balance" {
#   source      = "./modules/create_A_DNS_Load_Balance"
#   api_token   = var.cloudflare_api_token
#   email       = var.email
#   api_key     = var.api_key
#   zone_id     = var.cloudflare_zone_id
#   name        = var.dns_name
#   value       = var.dns_value
#   name2       = var.dns_name2
#   value2      = var.dns_value2
#   domain      = var.domain
#   pool_name   = var.pool_name
#   load_balancer_name = var.load_balancer_name
#   tls         = var.tls
#   login_limit = var.login_limit
#   load_balancer_monitor = var.load_balancer_monitor
#   load_balancer_pool = var.load_balancer_pool
# }
