init:
	terraform init --upgrade

check:
	terraform fmt -recursive
	terraform validate

plan:
	terraform plan -var-file terraform.tfvars

test:
	terraform test

integration_test:
	terraform test -filter=test_mock.tftest.hcl

e2e_test:
	terraform test -filter=test_e2e.tftest.hcl

deploy:
	terraform apply -var-file terraform.tfvars -auto-approve

destroy:
	terraform apply -var-file terraform.tfvars -auto-approve -destroy