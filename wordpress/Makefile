network:
	# TODO - Detect if network exists and if so, just start
	docker network create wordpress

mysql:
	# TODO - Detect if container exists and if so, just start
	docker container run \
		--name dd-mysql-db \
		--detach \
		--env-file mysql.env \
		--network wordpress \
		--network-alias db \
		--hostname db \
		--restart on-failure \
		mysql:5.7

wordpress:
	docker image build --tag wordpressdd:latest .
	# TODO - Detect if container exists and if so, just start
	docker container run \
		--name dd-wordpress \
		--detach \
		--network wordpress \
		--env-file wordpress.env \
		--hostname wordpress \
		--restart on-failure \
		-p 8080:80 \
		wordpressdd:latest

start: network mysql wordpress

stop:
	docker container stop dd-wordpress
	docker container stop dd-mysql-db
	docker network remove wordpress

destroy:
	-docker container rm --force dd-wordpress
	-docker container rm --force dd-mysql-db
	-docker network remove wordpress
