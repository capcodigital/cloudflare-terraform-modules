module "dns" {
  source     = "./modules/dns"
  zone_id    = var.zone_id
  domain     = var.domain
  name       = var.name
  value      = var.value
  tls        = var.tls
  rate_limit = var.rate_limit
}

module "load_balancer" {
  source                = "./modules/load_balancer"
  zone_id               = var.zone_id
  domain                = var.domain
  dns                   = var.dns
  tls                   = var.tls
  rate_limit            = var.rate_limit
  pool_name             = var.pool_name
  load_balancer_name    = var.load_balancer_name
  load_balancer_monitor = var.load_balancer_monitor
  load_balancer_pool    = var.load_balancer_pool
  notification_email    = var.notification_email
}
