IMAGE_NAME=rabbitbird/simple-server
VERSION=latest
WORKDIR=/usr/src/app
PORT=8080

build:
	docker image build -t $(IMAGE_NAME):$(VERSION) .

run:
	docker container run --rm -it -d -p $(PORT):$(PORT) $(IMAGE_NAME):$(VERSION) $(CMD)

dev: build
	docker container run --rm -it -p $(PORT):$(PORT) -v "$(CURDIR)"/bin:$(WORKDIR)/bin $(IMAGE_NAME):$(VERSION) $(CMD)
