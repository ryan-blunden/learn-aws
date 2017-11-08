#######################
#  AWS LINUX AND CLI  #
#######################

IMAGE_NAME=vmware-awslinux
VERSION=latest

awslinux-build:
	docker build -t $(IMAGE_NAME):$(VERSION) awslinux

awslinux-run: awslinux-build
	docker run --rm -it $(IMAGE_NAME) bash
