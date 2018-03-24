FROM python:3.6.4-slim-stretch

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends jq less && \
    rm -rf /var/lib/apt/lists/*

COPY Pipfile Pipfile

RUN ln -s /usr/local/bin/python /bin/python && \
    pip install pip setuptools --upgrade && \
    pip install pipenv && \
    pipenv install --deploy --system

COPY bin bin

RUN printf "\ncomplete -C '/usr/local/bin/aws_completer' aws" >> /root/.bashrc

CMD ["bash"]
