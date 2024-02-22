# Materiały dodatkowe do podcastu "Everything as a code"

### Odcinek 1 - Czym się rózni "infrastructure as code" od "configuration as code" ?

Narzędzia:
- narzędzia:
  - IaC:
    - [Terraform](https://www.terraform.io/)
    - [Pulumi](https://pulumi.com/)
    - [CloudFormation](https://aws.amazon.com/cloudformation/)
    - [AWS CDK (Cloud Development Kit)](https://aws.amazon.com/cdk/)
    - [ARM (Azure Resource Manager) Templates](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/overview)
    - [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)
    - [Google Cloud Deployment Manager](https://cloud.google.com/deployment-manager/docs)
  - CaC:
    - [Ansible](https://www.ansible.com/)
    - [Puppet](https://www.puppet.com/)
    - [Chef](https://www.chef.io/)

Przykłady:
- [Terraform + AWS](episode-001/terraform-aws/)
- [Terraform + OCI](episode-001/terraform-oracle/)
- [Ansible](episode-001/ansible-local/)

### Odcinek 2 - W jaki sposób definiowac infrastrukturze w chmurze za pomocą kodu ?

Przykłady:
- [aplikacja webowa z bazą danych](episode-002/terraform-oracle/) - **Uwaga** : ze względu na brak zasobów w ramach always free w Oracle (stan na 17.02.2024) fragmenty kodu wdrazające maszynę wirtuąlną są zakomentowane
- [funkcja do wysyłania powiadomień mailowych](episode-002/pulumi-aws/)

### Odcinek 3 - Klaster Kubernetes do nauki

Przykłady:
- [k8s-oci](https://github.com/sebastianczech/k8s-oci)
- [k8s-oci-tf-cloud](https://github.com/sebastianczech/k8s-oci-tf-cloud)

Moduły Terraform:
- [infra-k8s-oracle-cloud](https://registry.terraform.io/modules/sebastianczech/infra-k8s-oracle-cloud/oci/latest)
- [conf-k8s-oracle-cloud](https://registry.terraform.io/modules/sebastianczech/conf-k8s-oracle-cloud/oci/latest)