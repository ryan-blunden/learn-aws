FROM amazonlinux:latest

WORKDIR /usr/src/app

RUN yum -y update
RUN yum -y upgrade
RUN yum install -y python36

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG en_US.utf8

RUN pip-3.6 install pip --upgrade && \
    pip install chalice
