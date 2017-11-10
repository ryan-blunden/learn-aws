awslinux-build:
	docker build -t awslinux:latest awslinux

awslinux-run: awslinux-build
	docker run --rm -it awslinux bash

dynamodb-build:
	docker build -t dynamodb:latest dynamodb

dynamodb-run: dynamodb-build
	docker run --rm -it -p 8000:8000 dynamodb
