FROM alpine:3.19

RUN apk add --no-cache curl

RUN curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && \
    sh /tmp/netdata-kickstart.sh --disable-telemetry && \
    rm /tmp/netdata-kickstart.sh

# create the cloud configuration directory and file
RUN mkdir -p /opt/netdata/var/lib/netdata/cloud.d && \
echo "[cloud]" > /opt/netdata/var/lib/netdata/cloud.d/cloud.conf && \
echo "  token = 'placeholder_cloud_token'" >> /opt/netdata/var/lib/netdata/cloud.d/cloud.conf

EXPOSE 19999

# run netdata in the foreground
ENTRYPOINT [ "/opt/netdata/bin/netdata", "-D" ]
