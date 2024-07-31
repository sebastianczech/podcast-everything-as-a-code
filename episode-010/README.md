# Odcinek 10 - Uwierzytelnianie i dane wrażlie w pipeline CI/CD

Materiały:
- [OpenID Connect](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments)
  - [AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
  - [Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
  - [GCP](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-google-cloud-platform)
- Secrets:
  - [Using secrets in GitHub Actions](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
  - [Vault GitHub Action](https://github.com/hashicorp/vault-action)
  - [Use AWS Secrets Manager secrets in GitHub jobs](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieving-secrets_github.html)
  - [GitHub Action to fetch secrets from Azure Key Vault](https://github.com/marketplace/actions/get-secrets-from-azure-key-vault)
- Minimal permissions (from CI/CD perspective):
  - [GitHub Actions](https://docs.github.com/en/actions/using-jobs/assigning-permissions-to-jobs)
  - [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/pipelines/policies/permissions?view=azure-devops)
- Minimal permissions (from cloud perspective):
  - [Configuring a role for GitHub OIDC identity provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub)
  - [Scopes and permissions in the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/scopes-oidc#openid-connect-scopes)
- [Review third party actions](https://www.stepsecurity.io/blog/third-party-github-actions-governance-best-practices)
- Secure sensitive data:
  - [Terraform state](https://developer.hashicorp.com/terraform/language/state/sensitive-data)
  - [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html)
- Best practicies:
  - [Dependabot - Automated dependency updates built into GitHub](https://github.com/dependabot)
  - [Checkov - Integrating with CI/CD](https://www.checkov.io/1.Welcome/Feature%20Descriptions.html)
  - [Trivy - comprehensive and versatile security scanner](https://github.com/aquasecurity/trivy)