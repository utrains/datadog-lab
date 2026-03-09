# Lab 3 - Multi-service Trace Chain + Datadog

This Terraform stack creates a dedicated VPC with one public subnet, then launches one EC2 instance, installs Docker + docker-compose, writes the lab application to disk, and starts the Datadog Agent plus the demo services automatically through cloud-init/user-data.

## What you need

- Terraform 1.5+
- AWS credentials configured locally
- A Datadog API key

## Quick start

```bash
terraform init
terraform plan -var="datadog_api_key=YOUR_KEY"
terraform apply -auto-approve -var="datadog_api_key=YOUR_KEY"
```

After apply, use the `app_url` and `api_url` outputs.

## Notes

- The instance uses Ubuntu 22.04 and installs Docker, docker-compose, curl, git, jq, and stress.
- Port `80` is used for the main demo app in Lab 2 and Lab 3.
- Port `5000` is exposed for the main API service in every lab.
- Port `8126` for Datadog APM is **not** exposed publicly.
- For production, restrict `allowed_ssh_cidr` and `allowed_http_cidr`.

- This stack does not rely on the default VPC; it builds its own dedicated VPC, Internet Gateway, route table, and one public subnet.
