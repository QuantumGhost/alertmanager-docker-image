FROM alpine:3.4

ARG ALERTMANAGER_VERSION

ENV ALERTMANAGER_VERSION=$ALERTMANAGER_VERSION

COPY dist/simple.yml                /data/alertmanager.yml
COPY dist/alertmanager              /bin/alertmanager

EXPOSE 9093
VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/alertmanager"]
CMD  [ "-config.file=/data/alertmanager.yml", \
       "-storage.path=/data"]
