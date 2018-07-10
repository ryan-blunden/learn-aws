IMAGE=minio/minio:latest
PORT=9000
MINIO_ACCESS_KEY=JZ2ACMY43EXTMVWVOYZD
MINIO_SECRET_KEY=7Xn9y+YKQdJ2azRR2QmKDqa9ksa4zfwGcyjq/saS

run:
	docker container run \
		--rm \
		-v "$(CURDIR)/data":/data \
		-p $(PORT):$(PORT) \
		-e MINIO_ACCESS_KEY=$(MINIO_ACCESS_KEY) \
		-e MINIO_SECRET_KEY=$(MINIO_SECRET_KEY) \
		$(IMAGE) \
		server /data
