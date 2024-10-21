# Odcinek 20 - k6 - generowanie testowego ruchu

Narzędzia:
- [k6 - Grafana Labs](https://k6.io/)
- [k6 - GitHub](https://github.com/grafana/k6)
- [Get started - Install k6](https://grafana.com/docs/k6/latest/set-up/install-k6/)
- [Get started - Running k6](https://grafana.com/docs/k6/latest/get-started/running-k6/)
- [k6 extension - access metrics on a web-based dashboard](https://github.com/grafana/xk6-dashboard)

Przykład użycia:
1. Wygeneruj skrypt: `k6 new`
2. Uruchom narzędzie: `k6 run script.js`
3. Uruchom `k6` z 1 wirutalnym użytkownikiem przez 10 sekund: `k6 run --vus 1 --duration 10s script.js`
4. Uruchom `k6` z modułem `browser`: `k6 run browser.js`