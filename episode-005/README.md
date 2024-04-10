# Odcinek 5 - Testowanie infrastruktury, piramida testów

Materiały:
  * [HashiCorp - Testing HashiCorp Terraform](https://www.hashicorp.com/blog/testing-hashicorp-terraform)
  * [HashiCorp - Test-Driven Development (TDD) for Infrastructure](https://www.hashicorp.com/resources/test-driven-development-tdd-for-infrastructure)
  * [HashiCorp - Testing Infrastructure as Code on Localhost](https://www.hashicorp.com/resources/testing-infrastructure-as-code-on-localhost)
  * [Design by Contract in Terraform](https://betterprogramming.pub/design-by-contracts-in-terraform-63467a749c1a)
  * [TDD vs TLD and what is the minimum code coverage needed](https://medium.com/swlh/tdd-vs-tld-and-what-is-the-minimum-code-coverage-needed-f380181d3400)
  * [DevOpsDays Warsaw 2022 - Sebastian Czech - Build infrastructure as a code (IaC) using test-later development (TLD) method](https://youtu.be/XY5LD2zy0eY?si=5BFggg3qJIpNGRln)
  * [HashiCorp - Tests - testing framework is available in Terraform v1.6.0 and later](https://developer.hashicorp.com/terraform/language/tests)
  * [HashiCorp - Checks - validate your infrastructure outside the usual resource lifecycle](https://developer.hashicorp.com/terraform/language/checks)
  * [HashiCorp - Mocks - mocking is available in Terraform v1.7.0 and later](https://developer.hashicorp.com/terraform/language/tests/mocking)
  * [HashiCorp - Terraform 1.7 adds test mocking and config-driven remove](https://www.hashicorp.com/blog/terraform-1-7-adds-test-mocking-and-config-driven-remove)
  * [OpenTofu - Command: test](https://opentofu.org/docs/cli/commands/test/)
  * [OpenTofu - What We Learned While Working on OpenTofu's New Test Feature](https://opentofu.org/blog/what-we-learned-while-working-on-opentofus-new-test-feature/)
  * [Spacelift - OpenTofu Tutorial – Getting Started, How to Install & Examples](https://spacelift.io/blog/opentofu-tutorial)
  * [Spacelift - Testing your Configuration with OpenTofu](https://www.youtube.com/watch?v=XjCS3vKLpkw&ab_channel=Spacelift)

Kurs:
  * [Test IaC on AWS](https://github.com/sebastianczech/aws-terratest-course)

Przykłady:

1. Przygotowanie kodu infrastruktury:

```bash
terraform init
```

2. Walidacja:

```bash
terraform validate
```

3. Testy kontraktowe:

```bash
terraform plan
```

4. Testy integracyjne:

```bash
// mock
```

5. Test funkcjonalne (E2E):

```bash
terraform test
```
