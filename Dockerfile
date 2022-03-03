FROM docker.io/goacme/lego:latest

ADD *.sh /usr/local/bin/

RUN apk --update add curl tini
RUN curl -LO "https://dl.k8s.io/release/v1.22.7/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN mkdir -p /data
VOLUME [ "/data" ]
WORKDIR /data

ENV DOMAIN_NAME
ENV EMAIL
ENV DNS_RESOLVERS
ENV DNS_PROVIDER

ENTRYPOINT [ "tini", "--" ]
CMD ["/usr/local/bin/renew.sh"]