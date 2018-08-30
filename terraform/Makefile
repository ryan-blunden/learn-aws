.PHONY: exec build

IMAGE_NAME=rabitbird/terraform
VERSION=latest
WORKDIR=/usr/src/app

TERRAFORM_VERSION=0.11.8
TERRAFORM_SHA=84ccfb8e13b5fce63051294f787885b76a1fedef6bdbecf51c5e586c9e20c9b7

build:
	docker image build --build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) --build-arg TERRAFORM_SHA=$(TERRAFORM_SHA) -t $(IMAGE_NAME):$(VERSION) .

exec:
	docker container run \
		--rm \
		-it \
		--env-file aws.env \
		--workdir $(WORKDIR) \
		-v "$(TERRAFORM_MODULE)":/usr/src/app $(IMAGE_NAME):$(VERSION) \
		$(CMD)
