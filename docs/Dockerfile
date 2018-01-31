FROM python:3.6-slim

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends make nano patch && \
    rm -rf /var/lib/apt/lists/*

#
## PYTHON DEPENDENCIES
#

# Temporary workaround for mkdocs install failure. - https://github.com/kennethreitz/pipenv/issues/955
RUN ln -s /usr/local/bin/python /bin/python

COPY Pipfile docs bin livereload-server.py.patch ./

RUN pip install pip setuptools --upgrade && \
    pip install pipenv && \
    pipenv install --system --deploy

#
## MKDOCS
#

# Remove the host:port config in the JS live reload so live-reloading works.
# Credit: https://github.com/metal3d/docker-mkdocs/blob/master/livereload.patch
RUN patch /usr/local/lib/python3.6/site-packages/livereload/server.py livereload-server.py.patch

EXPOSE 8000

CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
