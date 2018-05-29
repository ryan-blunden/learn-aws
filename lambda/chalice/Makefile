IMAGE_NAME=rabbitbird/chalice
VERSION=1.0
WORKDIR=/usr/src/app

build:
	docker image build -t $(IMAGE_NAME):$(VERSION) .

run: build
	docker container run --rm -it $(IMAGE_NAME):$(VERSION)

dev: build
	docker container run --rm -it -p 8000:8000 -v "$(CURDIR)":$(WORKDIR) $(IMAGE_NAME):$(VERSION)
