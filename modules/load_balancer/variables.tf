variable "zone_id" {
  type      = string
  sensitive = true
}
variable "domain" {
  type = string
}
variable "dns" {
  type = list(object({
    name    = string
    value   = string
    enabled = bool
  }))
}
variable "ttl" {
  type    = number
  default = 3600
}
variable "pool_name" {
  type = string
}
variable "load_balancer_name" {
  type = string
}
variable "notification_email" {
  type = string
}
variable "tls" {
  type    = bool
  default = false
}
variable "rate_limit" {
  type    = bool
  default = false
}
variable "load_balancer_monitor" {
  type    = bool
  default = false
}
variable "load_balancer_pool" {
  type    = bool
  default = false
}
variable "schemes" {
  type    = list(string)
  default = ["HTTPS"]
}
variable "methods" {
  type    = list(string)
  default = []
}
variable "statuses" {
  type    = list(number)
  default = [200, 201, 202, 301, 429]
}
variable "threshold" {
  type    = number
  default = 5
}
variable "period" {
  type    = number
  default = 60
}
variable "timeout" {
  type    = number
  default = 43200
}
