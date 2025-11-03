ARG CADDY_VERSION
FROM caddy:${CADDY_VERSION:-2.10.2}-builder AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/porech/caddy-maxmind-geolocation

RUN mkdir -p /usr/share/caddy && \
    wget -O /usr/share/caddy/GeoLite2-Country.mmdb "https://git.io/GeoLite2-Country.mmdb"

FROM caddy:${CADDY_VERSION:-2.10.2}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY --from=builder /usr/share/caddy/GeoLite2-Country.mmdb /usr/share/caddy/GeoLite2-Country.mmdb
COPY root/ /
