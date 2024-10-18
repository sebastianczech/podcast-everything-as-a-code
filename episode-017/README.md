# Odcinek 17 - Gitleaks - weryfikacja czy w repozytorium Git nie ma poufnych informacji


Narzędzia:
- [gitleaks](https://github.com/gitleaks/gitleaks)
- [gitleaks-action](https://github.com/gitleaks/gitleaks-action)

Przykłady użycia:

1. Z linii komend po zainstalowaniu narzędzia `gitleaks`:

```bash
> gitleaks git -v

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

7:46PM INF 100 commits scanned.
7:46PM INF scan completed in 42.5ms
7:46PM INF no leaks found

> gitleaks dir -v

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

7:46PM INF scan completed in 49.8ms
7:46PM INF no leaks found
```

2. Jak jedno z zadań wykonywanych przez `pre-commit`:

```bash
> pre-commit run --all-files
[INFO] Initializing environment for https://github.com/gitleaks/gitleaks.
[INFO] Installing environment for https://github.com/gitleaks/gitleaks.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
..........
Detect hardcoded secrets.................................................Passed
..........
```
po dodaniu do `.pre-commit-config.yaml`:
```yaml
-   repo: https://github.com/gitleaks/gitleaks
    rev: v8.21.0
    hooks:
      - id: gitleaks
```

Przykład wykrycia haseł w katalogu:

```bash
> echo "aws_access_key_id = 123ghjTEST987" > inject_credentials
> gitleaks dir -v

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

Finding:     aws_access_key_id = 123ghjTEST987
Secret:      123ghjTEST987
RuleID:      generic-api-key
Entropy:     3.546594
File:        inject_credentials
Line:        1
Fingerprint: inject_credentials:generic-api-key:1

7:50PM INF scan completed in 2.06ms
7:50PM WRN leaks found: 1
```