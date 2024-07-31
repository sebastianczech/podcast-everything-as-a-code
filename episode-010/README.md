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

Przykłady:

1. [Uwierzytelnianie w chmurze AWS za pomocą OpenID Connect w GitHub](https://github.com/aws-actions/configure-aws-credentials):
```yaml
name: Run AWS with OIDC
on: [push]

permissions:
  id-token: write
  contents: read
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Configure AWS Credentials
      uses: aws-actions/configure-aws-credentials@v4
      with:
        aws-region: us-east-2
        role-to-assume: arn:aws:iam::123456789100:role/my-github-actions-role
        role-session-name: MySessionName
```

2. [Uwierzytelnianie w chmurze Azure za pomocą OpenID Connect w GitHub](https://github.com/Azure/login):
```yaml
name: Run Azure Login with OIDC
on: [push]

permissions:
  id-token: write
  contents: read
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Azure login
        uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Azure CLI script
        uses: azure/cli@v2
        with:
          azcliversion: latest
          inlineScript: |
            az account show
```