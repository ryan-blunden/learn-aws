IMAGE_NAME=rabbitbird/wait-for-it
VERSION=latest
WORKDIR=/usr/src/app

build:
	docker image build -t $(IMAGE_NAME):$(VERSION) .

wait:
	docker container run $(IMAGE_NAME):$(VERSION) -t 120 $(for)
