# Odcinek 4 - Co oznacza idempotentny, deklaratywny, imperatywny ?

Przykłady:

- Ansible - deklaratywny moduł:

```yaml
- name: Ensure nginx is installed
  package:
    name: nginx
    state: present
```

- Ansible - imperatywny moduł:

```yaml
- name: Create a directory
  command: mkdir /path/to/directory
```

- Terraform - deklaratywny zasób:

```hcl
resource "aws_instance" "this" {
  ami           = "ami-12345678901234567"
  instance_type = "t2.micro"
}
```

- Terraform - imperatywny zasób:

```hcl
resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "echo 'This is a provisioner script'"
  }

  depends_on = [aws_instance.this]
}
```