FROM debian:latest

ENV HTTPADDR 80
ENV HTTPSADDR 443
ENV TUNNELADDR 4443
ENV DOMAIN ""
ENV TLSKEY /etc/ssl/snakeoil.key
ENV TLSCRT /etc/ssl/snakeoil.crt
ENV LOGLEVEL "WARNING"
ENV AUTHTOKEN ""

VOLUME /etc/ssl

COPY bin/ngrokd /usr/local/bin/
COPY assets/server/tls/ /usr/local/src/ssl/
COPY docker/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x  /usr/local/bin/ngrokd
RUN chmod +x  /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
