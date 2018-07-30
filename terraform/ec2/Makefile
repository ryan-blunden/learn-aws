init:
	cd ../ && "$(MAKE)" exec TERRAFORM_MODULE="$(CURDIR)" CMD="terraform init -upgrade"

plan:
	cd ../ && "$(MAKE)" exec TERRAFORM_MODULE="$(CURDIR)" CMD="terraform plan -var-file terraform.tfvars"

apply:
	cd ../ && "$(MAKE)" exec TERRAFORM_MODULE="$(CURDIR)" CMD="terraform apply -auto-approve -var-file terraform.tfvars"

destroy:
	cd ../ && "$(MAKE)" exec TERRAFORM_MODULE="$(CURDIR)" CMD="terraform destroy -force -var-file terraform.tfvars"

output:
	cd ../ && "$(MAKE)" exec TERRAFORM_MODULE="$(CURDIR)" CMD="terraform output -json"
