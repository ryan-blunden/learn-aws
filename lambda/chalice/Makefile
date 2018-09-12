IMAGE_NAME=rabbitbird/chalice
VERSION=1.0
WORKDIR=/usr/src/app

build:
	docker image pull amazonlinux:latest
	docker image build -t $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):latest .

dev: build
	docker container run --rm -it -p 8000:8000 -v "$(CURDIR)":$(WORKDIR) $(IMAGE_NAME):$(VERSION)
