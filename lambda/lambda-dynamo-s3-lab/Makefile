init:
	terraform init -upgrade

zip:
	zip lambda_function.zip lambda_function.py

plan: zip
	terraform plan -var-file terraform.tfvars

apply:
	terraform apply -auto-approve -var-file terraform.tfvars

destroy:
	terraform destroy -force -var-file terraform.tfvars

output:
	terraform output -json
