FROM alpine:3.9 as builder

RUN \
  # install build dependencies
  apk --update --no-cache add --virtual build-deps \
    git autoconf make gcc automake musl-dev \
    jansson-dev yaml-dev libxml2-dev && \
  # build, install universal-ctags
  git clone http://github.com/universal-ctags/ctags.git ~/ctags && \
  cd ~/ctags && \
  ./autogen.sh && \
  ./configure && make && make install

FROM alpine:3.9
LABEL maintainer="Universal Ctags <uctags@vicaya.com>" license="MIT"

RUN apk --update --no-cache add jansson yaml libxml2
COPY --from=builder /usr/local/bin/ctags /usr/local/bin/

WORKDIR /workspace
ENTRYPOINT ["ctags"]