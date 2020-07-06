module "DNS_A" {
  source = "./modules/create_A_DNS"
  api_token = var.cloudflare_api_token
  zone_id   = var.cloudflare_zone_id 
  name      = var.dns_name
  value     = var.dns_value
}

