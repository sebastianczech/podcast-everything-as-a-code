# Odcinek 12 - Jak zaczac przygode z Ansible ?

Materiały:
- [dokumentacja Ansible](https://docs.ansible.com/)
  - [playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html)
  - [zmienne](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html)
  - [inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)
  - [role](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html)
  - [dobre praktyki](https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- testowanie:
  - [moduł assert](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/assert_module.html)
  - [testowanie w Ansible](https://docs.ansible.com/ansible/latest/dev_guide/testing.html)
  - [strategie testowania](https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html)
- [Ansible vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html)

Przyklad:

1. Utwórz plik `ping.yaml`, którego celem będzie sprawdzenie połączenia z każdym z serwerów za pomocą `ping`:

```yaml
---
- hosts: all
  tasks:
    - name: test connection
      ping:
```

2. Utwórz `inventory.yaml`, który zawiera tylko lokalną stację roboczą:

```yaml
lab:
  hosts:
    localhost:
      ansible_connection: local
```

3. Uruchom plabyook:

```bash
ansible-playbook -i inventory.yaml ping.yml
```