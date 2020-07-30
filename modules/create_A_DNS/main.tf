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
