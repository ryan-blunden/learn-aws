FROM amazonlinux:latest

WORKDIR /usr/src/app

RUN yum -y upgrade && \
    yum install -y python3 less && \
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
