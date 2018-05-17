IMAGE_NAME=rabbitbird/chalice
VERSION=1.0
WORKDIR=/usr/src/app

build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

run: build
	docker run --rm -it $(IMAGE_NAME):$(VERSION)

dev: build
	docker run --rm -it -p 8000:8000 -v "$(CURDIR)":$(WORKDIR) $(IMAGE_NAME):$(VERSION)
