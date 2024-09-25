# Odcinek 13 - Jak zbudowac własny moduł w Ansible ?

Materiały:
- [implementowanie własnego modułu Ansible](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html)

Przykład:

1. Rozbuduj kod z [poprzedniego odcinka](../episode-012/) poprzez utworzenie nowego playbooka `my_module.yml`:
```yaml
---
- hosts: all
  tasks:
    - name: use own module
      my_module:
        name: podcast
        new: true
```

2. Utwórz nowy moduł w pliku [`library/my_module.py`](library/my_module.py).

2. Uruchom kod:
```bash
ansible-playbook -i inventory.yaml my_module.yml -v
```