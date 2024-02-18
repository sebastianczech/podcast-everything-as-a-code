# Terraform for AWS (Amazon Web Services)

## Links

* [AWS Free Tier](https://aws.amazon.com/free/)
* [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Get Started - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

## Prerequisites

* Installed tool [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* Account on [AWS](https://aws.amazon.com/console/)
  
## Usage

1. Prepare variables values by copying example and update lines with `# TODO`: `cp example.tfvars terraform.tfvars`
2. Initialize Terraform: `terraform init`
3. Check plan: `terraform plan`
4. Deploy infrastructure: `terraform apply -auto-approve`
