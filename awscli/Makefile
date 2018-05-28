IMAGE_NAME=rabbitbird/awscli
VERSION=latest
WORKDIR=/usr/src/app

build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

run: build
	docker run --rm -it $(IMAGE_NAME):$(VERSION)

dev: build
	docker run --rm -it -v "$(CURDIR)"/bin:$(WORKDIR)/bin $(IMAGE_NAME):$(VERSION)
