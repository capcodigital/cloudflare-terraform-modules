# shared ------------------------------------
zone_id    = "1cc14dda26244d352ca113851a05c61a"
domain     = "capco.io"
tls        = true
rate_limit = false
schemes    = ["HTTPS", "HTTP"]
methods    = ["GET"]
statuses   = [200, 201, 202]

# dns ---------------------------------------

name    = "dns"
value   = "8.8.8.8"
proxied = true

# load balancer -----------------------------
dns = [{
  name    = "www1"
  value   = "8.8.8.8"
  enabled = true
  },
  {
    name    = "www2"
    value   = "8.8.8.8"
    enabled = false
}]
load_balancer_monitor = true
load_balancer_pool    = true
pool_name             = "pool"
load_balancer_name    = "lb"
notification_email    = "jonathan.fenwick@delineate.io"
