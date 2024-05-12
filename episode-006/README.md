# Odcinek 6 - Jak zbudowac pipeline do wdrazania zmian w infrastrukturze ?

Materiały:
* dobre praktyki:
  * [Checkov - Policy-as-code for everyone](https://www.checkov.io/)
  * [pre-commit - a framework for managing and maintaining multi-language pre-commit hooks](https://pre-commit.com/)
  * [terraform-doc - a utility to generate documentation from Terraform modules in various output formats](https://github.com/terraform-docs/terraform-docs)
  * [Terraform fmt](https://developer.hashicorp.com/terraform/cli/commands/fmt)
  * [Infracost - Shift FinOps Left](https://www.infracost.io/)
* narzędzia CI/CD:
  * [GitLab](https://about.gitlab.com/)
  * [GitHub actions](https://github.com/features/actions)
  * [Azure DevOps](https://azure.microsoft.com/pl-pl/products/devops)
  * [Jenkins](https://www.jenkins.io/)
  * [TektonCD](https://tekton.dev/)
  * [Drone](https://www.drone.io/)
  * [Argo CD](https://argo-cd.readthedocs.io/en/stable/)
  * [Terraform Cloud / HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs)
* artykuły:
  * [How to implement CI/CD for IaC in practice? — part 0: introduction](https://medium.com/@l.halicki/how-to-implement-ci-cd-for-iac-in-practice-part-0-introduction-f76b4700818a)
  * [Deploying AWS Infrastructure using Terraform Scripts Through Jenkins Pipeline](https://medium.com/@vaishnavipolichetti/deploying-aws-infrastructure-using-terraform-scripts-through-jenkins-pipeline-3ee596d06aea)
  * [Provision AWS Infrastructure using Terraform & Jenkins – GitOps](https://www.linkedin.com/pulse/provision-aws-infrastructure-using-terraform-jenkins-gitops-sangode/)
  * [Git best practices: Workflows for GitOps deployments](https://developers.redhat.com/articles/2022/07/20/git-workflows-best-practices-gitops-deployments#next_steps)
  * [Argo CD - Declarative GitOps CD for Kubernetes](https://argo-cd.readthedocs.io/en/stable/user-guide/best_practices/)

Przykłady:
* [Konfiguracja narzędzia pre-commit](https://github.com/sebastianczech/k8s-oci-tf-cloud/blob/main/.pre-commit-config.yaml) uwzględniająca:
   * linting 
   * formatowanie kodu
   * generowanie dokumentacj
   * testy bezpieczeństwa za pomocą narzędzia `Checkov`
* [Testy jednotkowe, kontraktowe, integracyjne oraz funkcjonalne](https://github.com/sebastianczech/podcast-everything-as-a-code/blob/main/episode-005/README.md)