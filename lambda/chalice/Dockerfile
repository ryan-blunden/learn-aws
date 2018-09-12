FROM amazonlinux:latest

WORKDIR /usr/src/app

# Amazon Linux 2 installs Python 3.7 by default which is not compatible with Lambda (yet),
# so the below forces yum to ignore the `amzn2-core` repo.
RUN amazon-linux-extras enable python3 && \
    yum install -y --disablerepo amzn2-core python3 less && \
    yum clean all && \
    rm -rf /var/cache/yum

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG en_US.utf8

COPY requirements.txt .

RUN pip3 install pip --upgrade && \
    pip install -r requirements.txt && \
    rm -fr /root/.cache

EXPOSE 8000

CMD ["bash"]
