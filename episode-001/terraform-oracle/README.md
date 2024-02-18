# Terraform for OCI (Oracle Cloud Infrastructure)

## Links

* [OCI Cloud Free Tier - Always Free cloud service](https://www.oracle.com/uk/cloud/free/#always-free)
* [Oracle Cloud Infrastructure Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
* [Build infrastructure with Terraform on OCI](https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-build)

## Prerequisites

* Installed tool [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) and [OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)
* Account on [Oracle Cloud Infrastructure](https://cloud.oracle.com/)
  
## Usage

1. Authenticate in Oracle cloud: `oci session authenticate --region eu-frankfurt-1 --profile-name podcast-evcode --session-expiration-in-minutes 180`
2. Prepare variables values by copying example and update lines with `# TODO`: `cp example.tfvars terraform.tfvars`
3. Initialize Terraform: `terraform init`
4. Check plan: `terraform plan`
5. Deploy infrastructure: `terraform apply -auto-approve`
