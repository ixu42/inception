FROM alpine:3.19

RUN apk add --no-cache curl

RUN curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && \
    sh /tmp/netdata-kickstart.sh --disable-telemetry

EXPOSE 19999

# ENTRYPOINT [ "sleep", "100000" ]
ENTRYPOINT [ "/opt/netdata/bin/netdata" ]
