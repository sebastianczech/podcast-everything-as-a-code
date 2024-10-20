# Odcinek 19 - Super-Linter - dbanie o jakość kodu

Narzędzia:
- [Super-Linter](https://github.com/super-linter/super-linter)
- [How to Use GitHub Super Linter in Your Projects](https://www.freecodecamp.org/news/github-super-linter/)

Przykłady:
- [zastosowanie Super-Linter w GitHub workflow](https://github.com/sebastianczech/terraform-aws-free-serverless-modules/blob/07dfb862bdb9658128ee99aa6591a7b3283b1297/.github/workflows/pre-commit.yml#L29-L47)

```yaml
  superLinter:
    name: Lint
    runs-on: ubuntu-latest

    permissions:
      contents: read
      packages: read
      statuses: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Super-linter
        uses: super-linter/super-linter@v7.1.0
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```