provider "cloudflare" {
  version = "~> 2.0"
  email   = var.email
  api_key = var.api_key
  # api_token = var.api_token
}

resource "cloudflare_record" "a_dns" {
  provider = cloudflare
  zone_id = var.zone_id
  name    = var.name
  value   = var.value
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "a_dns_2" {
  provider = cloudflare
  zone_id = var.zone_id
  name    = var.name2
  value   = var.value2
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_zone_settings_override" "settings" {
    zone_id = var.zone_id
    count = var.tls == true ? 1 : 0
    settings {
      tls_1_3 = "on"
      automatic_https_rewrites = "on"
      ssl = "strict"
    }
}

resource "cloudflare_rate_limit" "example" {
  zone_id = var.zone_id
  count = var.login_limit == true ? 1 : 0
  threshold = 5
  period = 60
  match {
    request {
      url_pattern = "${var.domain}/*"
      schemes = ["HTTP", "HTTPS"]
      methods = ["GET", "POST", "PUT", "DELETE", "PATCH", "HEAD"]
    }
    response {
      statuses = [200, 201, 202, 301, 429]
      origin_traffic = false
    }
  }
  action {
    mode = "simulate"
    timeout = 43200
    response {
      content_type = "text/plain"
      body = "custom response body"
    }
  }
  correlate {
    by = "nat"
  }
  disabled = false
  description = "example rate limit for a zone"
  bypass_url_patterns = ["${var.domain}/bypass1","${var.domain}/bypass2"]
}


resource "cloudflare_load_balancer_monitor" "http_monitor" {
  count = var.load_balancer_monitor == true ? 1 : 0
  type = "http"
  expected_body = "alive"
  expected_codes = "2xx"
  method = "GET"
  timeout = 5
  path = "/"
  interval = 60
  retries = 5
  description = "GET / over HTTPS - expect 200"
  header {
    header = "Host"
    values = [var.domain]
  }
}

resource "cloudflare_load_balancer_pool" "pool" {
  count = var.load_balancer_pool == true ? 1 : 0
  name = var.pool_name
  origins {
    name = var.name
    address = var.value2
    enabled = false
  }
  origins {
    name = var.name2
    address = var.value2
  }
  description = "example load balancer pool"
  enabled = false
  minimum_origins = 1
  notification_email = var.email
}

resource "cloudflare_load_balancer" "bar" {
  count = var.load_balancer_pool == true ? 1 : 0
  zone_id = var.zone_id
  name = var.load_balancer_name
  fallback_pool_id = cloudflare_load_balancer_pool.pool.id
  default_pool_ids = [cloudflare_load_balancer_pool.pool.id]
  description = "example load balancer using geo-balancing"
  proxied = true
  steering_policy = "geo"
  pop_pools {
    pop = "LAX"
    pool_ids = [cloudflare_load_balancer_pool.pool.id]
  }
  region_pools {
    region = "WNAM"
    pool_ids = [cloudflare_load_balancer_pool.pool.id]
  }
}
