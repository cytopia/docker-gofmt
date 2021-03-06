FROM golang:stretch as builder

FROM alpine:3.9
LABEL \
	maintainer="cytopia <cytopia@everythingcli.org>" \
	repo="https://github.com/cytopia/docker-gofmt"
COPY --from=builder /usr/local/go/bin/gofmt /usr/local/bin/gofmt
COPY data/docker-entrypoint.sh /docker-entrypoint.sh

ENV WORKDIR /data
WORKDIR /data

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--help"]
