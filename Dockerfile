FROM alpine
MAINTAINER Gerónimo Afonso <geronimo.afonso@mikroways.net>

RUN apk add --update rsnapshot gettext sed

ENV RETAIN_HOURLY ${RETAIN:-23}
ENV RETAIN_DAILY ${RETAIN:-6}
ENV RETAIN_WEEKLY ${RETAIN:-3}
ENV RETAIN_MONTHLY ${RETAIN:-11}
ENV RETAIN_YEARLY ${RETAIN:-2}
ENV PREFIX ""

COPY rsnapshot.conf.tpl /etc/rsnapshot.conf.tpl 
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
VOLUME /root/.ssh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rsnapshot", "hourly"]
