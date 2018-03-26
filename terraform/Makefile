IMAGE_NAME=rabbitbird/terraform
VERSION=1.0
WORKDIR=/usr/src/app

clean:
	- @rm build 2> /dev/null
	- @del build 2> nul

build:
	docker image build -t $(IMAGE_NAME):$(VERSION) .
	- @touch build
	- @type nul >> build
