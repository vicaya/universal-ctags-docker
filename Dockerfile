FROM alpine:3.9 as builder

RUN \
  # install build-time dependencies
  apk --update --no-cache add --virtual build-deps \
    git autoconf make gcc automake musl-dev \
    jansson-dev yaml-dev libxml2-dev && \
  # build and install the universal-ctags binary
  git clone http://github.com/universal-ctags/ctags.git ~/ctags && \
  cd ~/ctags && ./autogen.sh && \
  ./configure && make && make install

FROM alpine:3.9
LABEL maintainer="vicaya <ctags@vicaya.com>" license="MIT"

# install run-time dependencies
RUN apk --update --no-cache add jansson yaml libxml2
COPY --from=builder /usr/local/bin/ctags /usr/local/bin/
RUN /usr/local/bin/ctags --version

WORKDIR /workspace
ENTRYPOINT ["ctags"]
