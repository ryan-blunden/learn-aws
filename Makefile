build:
	docker image pull python:3.6.5-slim-stretch
	cd awscli && "$(MAKE)" build

	docker image pull hashicorp/terraform:latest
	cd terraform/ec2 && "$(MAKE)" init
	cd terraform/vpc && "$(MAKE)" init

	docker image pull amazonlinux:latest
	cd lambda/chalice && "$(MAKE)" build

	docker image pull openjdk:8-jre-slim
	cd dynamodb && "$(MAKE)" build

	docker image pull minio/minio:latest
