IMAGE_NAME=rabbitbird/awscli
VERSION=latest
WORKDIR=/usr/src/app

build:
	docker image pull python:3.7-slim-stretch
	docker image build -t $(IMAGE_NAME):$(VERSION) .

run: build
	docker container run --rm -it $(IMAGE_NAME):$(VERSION) $(CMD)

dev: build
	docker container run --rm -it -v "$(CURDIR)"/bin:$(WORKDIR)/bin $(IMAGE_NAME):$(VERSION) $(CMD)
