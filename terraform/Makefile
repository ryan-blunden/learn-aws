.PHONY: exec

IMAGE_NAME=hashicorp/terraform
VERSION=light
WORKDIR=/usr/src/app

exec:
	docker container run \
		--rm \
		-it \
		--env-file aws.env \
		--entrypoint "" \
		--workdir $(WORKDIR) \
		-v "$(TERRAFORM_MODULE)":/usr/src/app $(IMAGE_NAME):$(VERSION) \
		$(CMD)
