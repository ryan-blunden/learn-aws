dynamodb-build:
	docker build -t dynamodb:latest .

dynamodb-run: dynamodb-build
	docker run --rm -it -p 8000:8000 dynamodb
	open http://localhost:8000/shell/
