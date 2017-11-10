FROM openjdk:8-jre-slim

WORKDIR /usr/src/app

EXPOSE 8000

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    rm -rf /var/lib/apt/lists/*

ARG DYNAMO_URL="https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz"
ARG DYNAMO_CHECKSUM_URL="https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz.sha256"

RUN wget --no-cookies ${DYNAMO_URL} && \
    wget --no-cookies ${DYNAMO_CHECKSUM_URL} && \
    sha256sum -c "dynamodb_local_latest.tar.gz.sha256" && \
    tar xfz dynamodb_local_latest.tar.gz && \
    rm dynamodb_local_latest.tar.gz*

CMD ["java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar", "-delayTransientStatuses"]
