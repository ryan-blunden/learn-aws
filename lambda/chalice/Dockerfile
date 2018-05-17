FROM amazonlinux:latest

WORKDIR /usr/src/app

RUN yum -y upgrade && \
    yum install -y python36 less && \
    yum clean all

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG en_US.utf8

COPY requirements.txt .

RUN pip-3.6 install pip --upgrade && \
    pip install -r requirements.txt

EXPOSE 8000

CMD ["bash"]
