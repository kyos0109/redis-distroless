FROM redis:4.0.11 as base

# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ARG TIME_ZONE

RUN mkdir -p /opt/etc && \
    cp -a --parents /lib/x86_64-linux-gnu/libm.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libdl.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libpthread.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libc.so.* /opt && \
    cp -a --parents /usr/local/bin/redis-server /opt && \
    cp -a --parents /usr/local/bin/redis-sentinel /opt && \
    cp /usr/share/zoneinfo/${TIME_ZONE:-ROC} /opt/etc/localtime


FROM gcr.io/distroless/base

COPY --from=base /opt /

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "redis-server" ]
