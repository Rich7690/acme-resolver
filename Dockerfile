FROM golang:1-alpine as builder

RUN apk --no-cache --no-progress add make git

WORKDIR /go

ENV GO111MODULE on

# Download go modules
RUN git clone https://github.com/go-acme/lego.git
WORKDIR /go/lego
RUN go mod download

RUN make build

FROM alpine:3.12
RUN apk update \
    && apk add --no-cache ca-certificates tzdata \
    && update-ca-certificates

COPY --from=builder /go/lego/dist/lego /usr/bin/lego

ADD *.sh /usr/local/bin/

RUN apk --update add curl tini
RUN curl -LO "https://dl.k8s.io/release/v1.24.5/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN mkdir -p /data
VOLUME [ "/data" ]
WORKDIR /data

ENV DOMAIN_NAME example.com
ENV EMAIL test@example.com
ENV DNS_RESOLVERS 1.1.1.1:53
ENV DNS_PROVIDER njalla
ENV SECRET_NAME prod-cert

ENTRYPOINT [ "/usr/local/bin/renew.sh" ]