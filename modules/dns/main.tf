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
  provider = cloudflare
  zone_id  = var.zone_id
  name     = var.name
  value    = var.value
  type     = "A"
  ttl      = var.proxied == true ? 1 : var.ttl
  proxied  = var.proxied
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = var.zone_id
  count   = var.tls == true ? 1 : 0
  settings {
    always_online            = "on"
    ssl                      = "strict"
    tls_1_3                  = "on"
    min_tls_version          = "1.2" //1.3 not supported by Httpie
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    brotli                   = "on"
    minify {
      css  = "off"
      html = "off"
      js   = "off"
    }
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
      origin_traffic = true
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
  description         = "Rate limit for a the zone '${var.zone_id}'"
  bypass_url_patterns = ["${var.domain}/bypass1", "${var.domain}/bypass2"]
}
