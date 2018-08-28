FROM redis:4.0.11 as base

RUN mkdir -p /opt/bin && \
    cp -a --parents /lib/x86_64-linux-gnu/libm.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libdl.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libpthread.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libc.so.* /opt && \
    cp -a /usr/local/bin/redis-server /opt/bin/. && \
    cp -a /usr/local/bin/redis-sentinel /opt/bin/.

FROM gcr.io/distroless/base

COPY --from=base /opt /

VOLUME /data
WORKDIR /data

CMD [ "redis-server" ]
