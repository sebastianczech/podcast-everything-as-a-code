auth:
	oci session authenticate --region eu-frankfurt-1 --profile-name podcast-evcode

init:
	terraform init --upgrade

check:
	terraform fmt -recursive
	terraform validate

plan:
	terraform plan -var-file terraform.tfvars

deploy:
	terraform apply -var-file terraform.tfvars -auto-approve

destroy:
	terraform apply -var-file terraform.tfvars -auto-approve -destroy