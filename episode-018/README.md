# Odcinek 18 - Checkov - sprawdzanie kodu infrastrucktury pod kątem bezpieczeństwa

Narzędzia:
- [Checkov](https://www.checkov.io/)
- [pre-commit hook](https://www.checkov.io/4.Integrations/pre-commit.html)
- [GitHub action](https://github.com/bridgecrewio/checkov-action)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [clowdhaus/terraform-composite-actions/pre-commit](https://github.com/clowdhaus/terraform-composite-actions)

Przykłady:
- [użycie `Checkov` jako jedno z zadań `pre-commit`](https://github.com/sebastianczech/terraform-aws-free-serverless-modules/blob/main/.pre-commit-config.yaml)

```yaml
-   repo: https://github.com/bridgecrewio/checkov.git
    rev: '3.2.219' # change to tag or sha
    hooks:
      - id: checkov
        verbose: true
        args: [
          --compact,
          --download-external-modules,"true",
          --quiet,
          --soft-fail,
          --skip-check, "CKV_AWS_26,CKV_AWS_27,CKV_AWS_28,CKV_AWS_50,CKV_AWS_116,CKV_AWS_119,CKV_AWS_117,CKV_AWS_158,CKV_AWS_173,CKV_AWS_272,CKV_AWS_338,CKV2_AWS_16",
          --soft-fail-on, "CKV2_GHA_1",
        ]
```

- [wywołanie `pre-commit` w ramach GitHub workflow](https://github.com/sebastianczech/terraform-aws-free-serverless-modules/blob/c99047c14dd88695c99b277c635ec8419145f1b3/.github/workflows/pre-commit.yml#L98)

```yaml
      - name: Pre-commit Terraform ${{ steps.minMax.outputs.maxVersion }}
        uses: clowdhaus/terraform-composite-actions/pre-commit@v1.9.0
        with:
          terraform-version: ${{ steps.minMax.outputs.maxVersion }}
          tflint-version: ${{ env.TFLINT_VERSION }}
          terraform-docs-version: ${{ env.TERRAFORM_DOCS_VERSION }}
```