IMAGE_NAME=autodesk-aws-site:latest
PORT=8000
AWS_DEFAULT_REGION=us-west-2

docker-build:
	docker build -t $(IMAGE_NAME) .

site-build: docker-build
	docker run -it --rm -v "$(CURDIR)":/usr/src/app $(IMAGE_NAME) mkdocs build --clean

site-server: docker-build
	docker run -it --rm \
	    -v "$(CURDIR)":/usr/src/app \
		-p $(PORT):$(PORT) \
	    $(IMAGE_NAME)

site-deploy:
	# Note: Expects AWS environmental vars to be set on host.
	docker run --rm \
        -e AWS_ACCESS_KEY_ID="$(AWS_ACCESS_KEY_ID)" \
        -e AWS_SECRET_ACCESS_KEY="$(AWS_SECRET_ACCESS_KEY)" \
        -e AWS_DEFAULT_REGION="$(AWS_DEFAULT_REGION)" \
        -v "$(CURDIR)":/usr/src/app \
        $(IMAGE_NAME) \
        ./bin/deploy.sh
