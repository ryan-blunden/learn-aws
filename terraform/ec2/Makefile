IMAGE_NAME=rabbitbird/terraform
VERSION=1.0
WORKDIR=/usr/src/app

init:
	docker container run --rm -it -v $(CURDIR):/usr/src/app $(IMAGE_NAME):$(VERSION) terraform init

plan:
	docker container run --rm -it -v $(CURDIR):/usr/src/app $(IMAGE_NAME):$(VERSION) terraform plan -var-file terraform.tfvars

apply:
	docker container run --rm -it -v $(CURDIR):/usr/src/app $(IMAGE_NAME):$(VERSION) terraform apply -auto-approve -var-file terraform.tfvars $(TARGET)

destroy:
	docker container run --rm -it -v $(CURDIR):/usr/src/app $(IMAGE_NAME):$(VERSION) terraform destroy -force -var-file terraform.tfvars $(TARGET)
