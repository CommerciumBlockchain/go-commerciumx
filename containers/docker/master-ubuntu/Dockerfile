FROM ubuntu:xenial

ENV PATH=/usr/lib/go-1.9/bin:$PATH

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang-1.9 git make gcc libc-dev ca-certificates && \
  git clone --depth 1 --branch release/1.7 https://github.com/CommerciumBlockchain/go-CommerciumX && \
  (cd go-CommerciumX && make cmmx) && \
  cp go-CommerciumX/build/bin/cmmx /cmmx && \
  apt-get remove -y golang-1.9 git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-CommerciumX

EXPOSE 7331
EXPOSE 13373

ENTRYPOINT ["/cmmx"]
