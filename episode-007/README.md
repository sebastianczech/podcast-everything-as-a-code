# Odcinek 7 - Flux, ArgoCD - jak zacząc pracę z uzyciem GitOps ?

Narzędzia:
- [Flux](https://fluxcd.io/)
- [Tofu Controller: An IAC Controller for Flux](https://github.com/flux-iac/tofu-controller)
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
- [Jenkins X](https://jenkins-x.io/v3/devops/gitops/)
- [Weave GitOps](https://github.com/weaveworks/weave-gitops)

Materiały:
- [Getting Started with Argo CD](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- [Get Started with Flux](https://fluxcd.io/flux/get-started/)
- [Ways of structuring your repositorie](https://fluxcd.io/flux/guides/repository-structure/)
- [Flux bootstrap](https://fluxcd.io/flux/installation/bootstrap/)

Przykłady:
- [repozytorium k8s-networking-gitops](https://github.com/sebastianczech/k8s-networking-gitops), które zawiera szczegółowe [README.md](https://github.com/sebastianczech/k8s-networking-gitops/blob/main/README.md) z komendami dla Flux, za pomocą których zintegrujesz Flux z GitHub oraz sprawdzisz w praktyce jak używać tego narzędzia:
  - instalacja narzędzia Flux CLI: `brew install fluxcd/tap/flux`
  - przygotowanie danych do uwierzytelnienia (GitHub PAT): `export GITHUB_TOKEN=<your-token>` oraz `export GITHUB_USER=<your-username>`
  - sprawdzenie klastra Kubernetes: `flux check --pre`
  - instalacja Flux w klastrze:
```
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=fleet-infra \
  --branch=main \
  --path=./clusters/my-cluster \
  --personal
```
  - przygotowanie `podinfo` w repozytorium z aplikacją:
```
flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=1m \
  --export > ./clusters/my-cluster/podinfo-source.yaml
```
  - wdrożenie aplikacji z `podinfo`:
```
flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --wait=true \
  --interval=30m \
  --retry-interval=2m \
  --health-check-timeout=3m \
  --export > ./clusters/my-cluster/podinfo-kustomization.yaml
```
  - weryfikacja wdrożenia: `flux get kustomizations --watch`