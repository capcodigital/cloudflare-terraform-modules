provider "cloudflare" {
  api_token = var.api_token
}

resource "cloudflare_record" "foobar" {
  provider = cloudflare
  zone_id = var.zone_id
  name    = var.name
  value   = var.value
  type    = "A"
  ttl     = 3600
}
