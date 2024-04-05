version: '2'

volumes:
  radarr-conf-files:
    driver: ${volumedriver}
services:
  radarr:
    image: linuxserver/radarr:109
    volumes:
    - radarr-conf-files:/config
    - ${DOWNLOAD_DIR}:/downloads
    - ${MOVIES_DIR}:/movies
    environment:
    - PGID=${GID}
    - PUID=${UID}
    - TZ=${TZ}
    labels:
      traefik.enable: true
      traefik.port: 7878
      traefik.frontend.rule: Host:${FQDN}
      io.rancher.container.hostname_override: container_name
#    healthcheck:
#      test: ["CMD", "curl", "-f", "http://localhost"]
#      interval: 1m30s
#      timeout: 10s
#      retries: 3
#      start_period: 30s
