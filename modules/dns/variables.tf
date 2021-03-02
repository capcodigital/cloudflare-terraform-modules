variable "zone_id" {
  type = string
}
variable "domain" {
  type = string
}
variable "name" {
  type = string
}
variable "value" {
  type = string
}
variable "proxied" {
  type    = bool
  default = true
}
variable "ttl" {
  type    = number
  default = 3600
}
variable "tls" {
  type    = bool
  default = false
}
variable "rate_limit" {
  type    = bool
  default = false
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
