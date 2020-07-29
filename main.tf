module "DNS_A" {
  source      = "./modules/create_A_DNS_Load_Balance/"
  api_token   = var.cloudflare_api_token
  zone_id     = var.cloudflare_zone_id 
  name        = var.dns_name
  value       = var.dns_value
  name2        = var.dns_name2
  value2       = var.dns_value2
  domain      = var.domain
  tls         = var.tls
  login_limit = var.login_limit
  load_balancer_monitor = var.login_limit
  load_balancer_pool = var.load_balancer_pool
}
