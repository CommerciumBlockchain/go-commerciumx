FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 https://github.com/CommerciumBlockchain/go-CommerciumX && \
  (cd go-CommerciumX && make cmmx) && \
  cp go-CommerciumX/build/bin/cmmx /cmmx && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-CommerciumX && rm -rf /var/cache/apk/*

EXPOSE 7331
EXPOSE 13373

ENTRYPOINT ["/cmmx"]
