FROM alpine
MAINTAINER Gerónimo Afonso <geronimo.afonso@mikroways.net>

RUN apk add --update rsnapshot
COPY rsnapshot.conf /etc/rsnapshot.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
VOLUME /root/.ssh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rsnapshot", "hourly"]
