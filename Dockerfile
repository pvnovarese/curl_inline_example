# example dockerfile that will use curl to download source, anchore
# will stop this with a simple package blacklist on curl
FROM alpine:latest 
MAINTAINER Paul Novarese pvn@novarese.net
LABEL name="curl_inline_example"
LABEL maintainer="pvn@novarese.net"
 
WORKDIR /
RUN apk update && apk add --no-cache build-base curl 
 
# download source and build
RUN curl -o - https://codeload.github.com/kevinboone/solunar_cmdline/zip/master | unzip -d / -
RUN cd /solunar_cmdline-master && make clean && make && cp solunar /bin/solunar
 
HEALTHCHECK NONE
USER 65534:65534
CMD ["-c", "London"]
ENTRYPOINT ["/bin/solunar"]
