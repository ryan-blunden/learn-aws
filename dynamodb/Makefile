IMAGE_NAME=rabbitbird/dynamodb
VERSION=1.0
PORT=8000
NAME=rabbitbird.dynamodb

build:
	docker image build -t $(IMAGE_NAME):$(VERSION) .

start: build
	docker container run --rm --name $(NAME) -d -P $(IMAGE_NAME):$(VERSION)
	@echo "\n[info]: Interactive JavaScript shell at http://localhost:`docker container inspect --format='{{(index (index .NetworkSettings.Ports "8000/tcp") 0).HostPort}}' $(NAME)`/shell/\n"

stop:
	docker container stop $(NAME)
