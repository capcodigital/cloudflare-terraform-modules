provider "cloudflare" {
  api_token = var.api_token
}

resource "cloudflare_record" "a_dns" {
  provider = cloudflare
  zone_id = var.zone_id
  name    = var.name
  value   = var.value
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_zone_settings_override" "example-com-settings" {
  zone_id = var.zone_id
  count = var.tls == true ? 1 : 0
  settings {
    tls_1_3 = "on"
    automatic_https_rewrites = "on"
    ssl = "strict"
  }
}

resource "cloudflare_rate_limit" "login-limit" {
  zone_id = var.zone_id
  count = var.login_limit == true ? 1 : 0

  threshold = 5
  period = 60
  match {
    request {
      url_pattern = "${var.domain}/login"
      schemes = ["HTTP", "HTTPS"]
      methods = ["POST"]
    }
    response {
      statuses = [401, 403]
      origin_traffic = true
    }
  }
  action {
    mode = "ban"
    timeout = 300
    response {
      content_type = "text/plain"
      body = "You have failed to login 5 times in a 60 second period and will be blocked from attempting to login again for the next 5 minutes."
    }
  }
  disabled = false
  description = "Block failed login attempts (5 in 1 min) for 5 minutes."
}

# resource "cloudflare_page_rule" "increase-security-on-expensive-page" {
#   zone = var.domain
#   target = "www.${var.domain}/expensive-db-call"
#   priority = 10

#   actions = {
#     security_level = "under_attack",
#   }
# }

# resource "cloudflare_page_rule" "redirect-to-new-db-page" {
#   zone = "${var.domain}"
#   target = "www.${var.domain}/old-location.php"
#   priority = 10

#   actions = {
#     forwarding_url {
#       url = "https://www.${var.domain}/expensive-db-call"
#       status_code = 301
#     }
#   }
# }