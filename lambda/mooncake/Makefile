IMAGE_NAME=rabbitbird/fortunecookie
VERSION=0.1
WORKDIR=/usr/src/app

build-docker:
	docker image build -t $(IMAGE_NAME):$(VERSION) .

run-docker: build-docker
	docker container run --rm -it -v $(CURDIR):$(WORKDIR) $(IMAGE_NAME):$(VERSION)\
