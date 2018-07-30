FROM python:3.7-slim

WORKDIR /usr/src/app

RUN pip install pystache

COPY . .

EXPOSE 8080

CMD ["python", "server.py"]
