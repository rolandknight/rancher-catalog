version: '2'

volumes:
  sickrage-conf-files:
    driver: ${volumedriver}
services:
  sickrage:
    image: linuxserver/sickrage:122
    volumes:
    - sickrage-conf-files:/config
    - ${DOWNLOAD_DIR}:/downloads
    - ${TV_DIR}:/tv
    environment:
    - PGID=${GID}
    - PUID=${UID}
    - TZ=${TZ}
#    ports:
#    - "8081:8081"
    labels:
      traefik.enable: true
      traefik.port: 8081
      traefik.frontend.rule: Host:${FQDN}
      traefik.frontend.whitelistSourceRange: ${WHITELIST}
      io.rancher.container.hostname_override: container_name
#    healthcheck:
#      test: ["CMD", "curl", "-f", "http://localhost"]
#      interval: 1m30s
#      timeout: 10s
#      retries: 3
#      start_period: 30s
