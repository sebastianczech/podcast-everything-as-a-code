# Terraform for OCI (Oracle Cloud Infrastructure)

## Links

* [OCI Cloud Free Tier - Always Free cloud service](https://www.oracle.com/uk/cloud/free/#always-free)
* [Oracle Cloud Infrastructure Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
* [Build infrastructure with Terraform on OCI](https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-build)

## Prerequisites

* Installed tool [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* Account on [Oracle Cloud Infrastructure](https://cloud.oracle.com/)
  
## Usage

```
cp example.tfvars terraform.tfvars
terraform init

terraform fmt -recursive
terraform validate

terraform plan
terraform apply -auto-approve
```
