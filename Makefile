build:
	docker image pull python:3.7-slim-stretch
	cd awscli && "$(MAKE)" build

	docker image pull alpine:latest
	cd terraform && "$(MAKE)" build

	docker image pull amazonlinux:latest
	cd lambda/chalice && "$(MAKE)" build

	docker image pull ubuntu:18.04
	cd utils/wait-for-it && \
	"$(MAKE)" build

	docker image pull minio/minio:latest

wait:
	cd utils/wait-for-it/ && \
	"$(MAKE)" wait
