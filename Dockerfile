FROM docker.io/goacme/lego:latest

ADD *.sh /usr/local/bin/

RUN apk --update add curl tini
RUN curl -LO "https://dl.k8s.io/release/v1.22.7/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN mkdir -p /data
VOLUME [ "/data" ]
WORKDIR /data

ENV DOMAIN_NAME example.com
ENV EMAIL test@example.com
ENV DNS_RESOLVERS 1.1.1.1:53
ENV DNS_PROVIDER njalla
ENV SECRET_NAME prod-cert

ENTRYPOINT [ "/bin/ash" ]