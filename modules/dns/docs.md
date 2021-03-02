## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.7, < 0.15.0 |
| cloudflare | >= 2.18.0, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | >= 2.18.0, < 3.0.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [cloudflare_rate_limit](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/rate_limit) |
| [cloudflare_record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) |
| [cloudflare_zone_settings_override](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | n/a | `string` | n/a | yes |
| methods | n/a | `list(string)` | `[]` | no |
| name | n/a | `string` | n/a | yes |
| period | n/a | `number` | `60` | no |
| proxied | n/a | `bool` | `true` | no |
| rate\_limit | n/a | `bool` | `false` | no |
| schemes | n/a | `list(string)` | <pre>[<br>  "HTTPS"<br>]</pre> | no |
| statuses | n/a | `list(number)` | <pre>[<br>  200,<br>  201,<br>  202,<br>  301,<br>  429<br>]</pre> | no |
| threshold | n/a | `number` | `5` | no |
| timeout | n/a | `number` | `43200` | no |
| tls | n/a | `bool` | `false` | no |
| ttl | n/a | `number` | `3600` | no |
| value | n/a | `string` | n/a | yes |
| zone\_id | n/a | `string` | n/a | yes |

## Outputs

No output.
