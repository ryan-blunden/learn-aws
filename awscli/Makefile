IMAGE_NAME=rabitbird/awscli
VERSION=1.1

awscli-build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

awscli-run: awscli-build
	docker run --rm -it $(IMAGE_NAME):$(VERSION)
