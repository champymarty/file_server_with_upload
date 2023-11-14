FROM alpine:latest

RUN apk update \
    && apk add openssl
RUN apk add --update python3 py3-pip

RUN mkdir keys
WORKDIR "/keys"
RUN openssl req -x509 -out server.pem -keyout server.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=server'
RUN openssl req -x509 -out client.pem -keyout client.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=client'
RUN openssl x509 -in client.pem -out client.crt

WORKDIR "/"
RUN mkdir data
WORKDIR "/data"
RUN python3 -m pip install --user uploadserver
EXPOSE 8081
CMD ["python3", "-m", "uploadserver", "--server-certificate", "../keys/server.pem", "--client-certificate", "../keys/client.crt", "8081"]