[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/capcodigital/cloudflare-terraform-modules">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Cloudflare Terraform Modules</h3>

  <p align="center">
    Provides a series of Terraform to simplify the provisioning of common Cloudflare resources
    <br />
    <a href="https://github.com/capcodigital/cloudflare-terraform-modules"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/capcodigital/cloudflare-terraform-modules/issues">Report Bug</a>
    ·
    <a href="https://github.com/capcodigital/cloudflare-terraform-modules/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

The purpose of this project is to simplify repeatable provisioning of Cloudflare resourcing.  Specifically the project looks to provide more resilient and secure setup than maybe accomplished if being implemented per project.

### Built With

* [Terraform](https://www.terraform.io/)
* [pre-commit](https://pre-commit.com/)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

It's recommended to use a `python` virtual environment, this example shows the creation using [pyenv](https://github.com/pyenv/pyenv) although this is not a requirement.

```shell
# create a virtual env to isolate pip installs
pyenv virtualenv 3.9.1 cloudflare-terraform-modules-3.9.1
```

### Installation

```shell
# clone the repo
git clone https://github.com/capcodigital/cloudflare-terraform-modules.git
cd cloudflare-terraform-modules

# installs the tooling requirements
pip install -r requirements.txt

# installs the git hook for pre-commit
pre-commit install
```

<!-- USAGE EXAMPLES -->
## Usage

### DNS Record

Whilst this may seem like a simple use case

```hcl
module "dns" {
  source     = "./modules/dns"
  zone_id    = var.zone_id
  domain     = var.domain
  name       = var.name
  value      = var.value
  tls        = var.tls
  rate_limit = var.rate_limit
}
```

### Load Balancer

```hcl
module "load_balancer" {
  source                = "./modules/load_balancer"
  zone_id               = var.zone_id
  domain                = var.domain
  dns                   = var.dns
  tls                   = var.tls
  rate_limit            = var.rate_limit
  pool_name             = var.pool_name
  load_balancer_name    = var.load_balancer_name
  load_balancer_monitor = var.load_balancer_monitor
  load_balancer_pool    = var.load_balancer_pool
  notification_email    = var.notification_email
}
```

## Provisioning

To create a Cloudflare token use the [Cloudflare Dashboard](https://dash.cloudflare.com).

```shell
# first make sure the API token is set as an env
export CLOUDFLARE_API_TOKEN=[TOKEN]

terraform plan
terraform apply
```

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/capcodigital/cloudflare-terraform-modules/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

If you would like to contribute to any Capco Digital OSS projects please read:

* [Code of Conduct](https://github.com/capcodigital/.github/blob/master/CODE_OF_CONDUCT.md)
* [Contributing Guidelines](https://github.com/capcodigital/.github/blob/master/CONTRIBUTING.md)

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [Best README Template](https://github.com/othneildrew/Best-README-Template/blob/master/README.md)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/capcodigital/cloudflare-terraform-modules.svg?style=for-the-badge
[contributors-url]: https://github.com/capcodigital/cloudflare-terraform-modules/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/capcodigital/cloudflare-terraform-modules.svg?style=for-the-badge
[forks-url]: https://github.com/capcodigital/cloudflare-terraform-modules/network/members
[stars-shield]: https://img.shields.io/github/stars/capcodigital/cloudflare-terraform-modules.svg?style=for-the-badge
[stars-url]: https://github.com/capcodigital/cloudflare-terraform-modules/stargazers
[issues-shield]: https://img.shields.io/github/issues/capcodigital/cloudflare-terraform-modules.svg?style=for-the-badge
[issues-url]: https://github.com/capcodigital/cloudflare-terraform-modules/issues
[license-shield]: https://img.shields.io/github/license/capcodigital/cloudflare-terraform-modules.svg?style=for-the-badge
[license-url]: https://github.com/capcodigital/cloudflare-terraform-modules/blob/master/LICENSE
