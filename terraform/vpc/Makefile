IMAGE_NAME=rabbitbird/terraform
VERSION=1.0
WORKDIR=/usr/src/app

exec:
	docker container run --rm -it -v "$(CURDIR)":/usr/src/app $(IMAGE_NAME):$(VERSION) $(CMD)

init:
	$(MAKE) exec CMD="terraform init"

plan:
	$(MAKE) exec CMD="terraform plan -var-file terraform.tfvars"

apply:
	$(MAKE) exec CMD="terraform apply -auto-approve -var-file terraform.tfvars"

destroy:
	$(MAKE) exec CMD="terraform destroy -force -var-file terraform.tfvars"

output:
	$(MAKE) exec CMD="terraform output"
