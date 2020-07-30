On the root folder create an environement variable for 'cloudflare_api_token':

`export TF_VAR_api_key="[YOUR API KEY]"`

or


`export TF_VAR_cloudflare_api_token="[YOUR TOKEN HERE]"`


Api keys and token are available on the cloudflare portal: https://dash.cloudflare.com/dbde1df0627ead83cd1e6df9bfe90be3/capco.io

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

For more info about terraform and cloudflare: https://www.terraform.io/docs/providers/cloudflare/index.html
