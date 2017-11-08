FROM python:3.6.3-slim

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY=""
ENV AWS_DEFAULT_REGION=""

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y make nano wget jq && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pip awscli mkdocs markdown-newtab --upgrade



WORKDIR /usr/src/app

COPY make_completion.sh /usr/src/app

CMD ["bash"]
