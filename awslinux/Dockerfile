FROM amazonlinux:latest

ENV LC_CTYPE=en_US.utf8
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8
ENV PYTHONUNBUFFERED=1

WORKDIR /usr/src/app

RUN yum -y update && \
    yum -y install python36 ncomplete jq less which -y && \
    yum clean all

RUN ln -s /usr/bin/python3 /bin/python && \
    easy_install-3.6 pip

COPY Pipfile .
RUN pip3 install pip setuptools --upgrade && \
    pip3 install pipenv && \
    pipenv install --deploy --system

COPY bin bin

RUN printf "\ncomplete -C '/usr/local/bin/aws_completer' aws" >> /root/.bashrc

CMD ["bash"]
