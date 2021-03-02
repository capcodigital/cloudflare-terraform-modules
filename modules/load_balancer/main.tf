terraform {
  required_version = ">= 0.14.7, < 0.15.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.18.0, < 3.0.0"
    }
  }
}

provider "cloudflare" {}

resource "cloudflare_record" "dns" {
  count   = length(var.dns)
  zone_id = var.zone_id
  name    = var.dns[count.index].name
  value   = var.dns[count.index].value
  type    = "A"
  ttl     = var.ttl
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = var.zone_id
  count   = var.tls == true ? 1 : 0
  settings {
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
  }
}

resource "cloudflare_rate_limit" "rate_limit" {
  zone_id   = var.zone_id
  count     = var.rate_limit == true ? 1 : 0
  threshold = var.threshold
  period    = var.period
  match {
    request {
      url_pattern = "${var.domain}/*"
      schemes     = var.schemes
      methods     = var.methods
    }
    response {
      statuses       = var.statuses
      origin_traffic = false
    }
  }
  action {
    mode    = "simulate"
    timeout = var.timeout
    response {
      content_type = "text/plain"
      body         = "custom response body"
    }
  }
  correlate {
    by = "nat"
  }
  disabled            = false
  description         = "rate limit for a zone"
  bypass_url_patterns = ["${var.domain}/bypass1", "${var.domain}/bypass2"]
}

resource "cloudflare_load_balancer_monitor" "http_monitor" {
  count          = var.load_balancer_monitor == true ? 1 : 0
  type           = "http"
  expected_body  = "alive"
  expected_codes = "2xx"
  method         = "GET"
  timeout        = 5
  path           = "/"
  interval       = 60
  retries        = 5
  description    = "GET / over HTTPS - expect 200"
  header {
    header = "Host"
    values = [var.domain]
  }
}

resource "cloudflare_load_balancer_pool" "pool" {
  count = var.load_balancer_pool == true ? 1 : 0
  name  = var.pool_name
  dynamic "origins" {
    for_each = var.dns
    content {
      name    = origins.value["name"]
      address = origins.value["value"]
      enabled = origins.value["enabled"]
    }
  }
  description        = "load balancer pool"
  enabled            = false
  minimum_origins    = 1
  notification_email = var.notification_email
}

resource "cloudflare_load_balancer" "load_balancer" {
  count            = var.load_balancer_pool == true ? 1 : 0
  zone_id          = var.zone_id
  name             = var.load_balancer_name
  fallback_pool_id = cloudflare_load_balancer_pool.pool[0].id
  default_pool_ids = cloudflare_load_balancer_pool.pool.*.id
  description      = "example load balancer using geo-balancing"
  proxied          = true
  steering_policy  = "geo"
  pop_pools {
    pop      = "LAX"
    pool_ids = cloudflare_load_balancer_pool.pool.*.id
  }
  region_pools {
    region   = "WNAM"
    pool_ids = cloudflare_load_balancer_pool.pool.*.id
  }
}
