FROM python:3.7-slim

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends nano jq less groff && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install pip setuptools --upgrade && \
    pip install -r requirements.txt && \
    rm -fr /root/.cache

COPY . .

EXPOSE 8080

CMD ["python", "server.py"]
