FROM python:3.7-slim-stretch

WORKDIR /usr/src/app

# Comment out this line so aptitude will install shared files for groff
# More info at https://github.com/aws/aws-cli/issues/1957#issuecomment-271057166
RUN sed -i.bak 's/path-exclude \/usr\/share\/groff/# &/' /etc/dpkg/dpkg.cfg.d/docker

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends nano jq less groff && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN ln -s /usr/local/bin/python /bin/python && \
    pip install pip setuptools --upgrade && \
    pip install -r requirements.txt

COPY bin bin

RUN printf "\ncomplete -C '/usr/local/bin/aws_completer' aws" >> /root/.bashrc

CMD ["bash"]
