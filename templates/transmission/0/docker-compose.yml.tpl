version: '2'

volumes:
  transmission-conf-files:
    driver: ${volumedriver}
services:
  transmission:
    image: gitlab.ionpig.com:5005/roland.knight/docker-transmission-openvpn
    devices:
    - /dev/net/tun
    cap_add:
    - NET_ADMIN
    secrets:
    - transmission_vpn_username
    - transmission_vpn_password
    volumes:
    - transmission-conf-files:/config
    - ${DOWNLOAD_DIR}:/data
    environment:
    - PGID=${GID}
    - PUID=${UID}
    - /etc/localtime:/etc/localtime:ro
    - LOCAL_NETWORK=${LOCAL_NETWORK}
    - OPENVPN_PROVIDER=${OPENVPN_PROVIDER}
    - OPENVPN_USERNAME_FILE=/run/secrets/transmission_vpn_username
    - OPENVPN_PASSWORD_FILE=/run/secrets/transmission_vpn_password
    - OPENVPN_OPTS=${OPENVPN_OPTS}
    - OPENVPN_CONFIG=${OPENVPN_CONFIG}
    - WEBPROXY_ENABLED=true
    ports:
    - "8888:8888"
    labels:
      traefik.enable: true
      traefik.port: 9091
      traefik.frontend.rule: Host:${FQDN}
      io.rancher.container.hostname_override: container_name
#    healthcheck:
#      test: ["CMD", "curl", "-f", "http://localhost"]
#      interval: 1m30s
#      timeout: 10s
#      retries: 3
#      start_period: 30s
#  proxy:
#    image: haugene/transmission-openvpn-proxy
#    links:
#      - transmission
#    ports:
#      - 8118:8080
#    volumes:
#      - /etc/localtime:/etc/localtime:ro
#  rss:
#    image: haugene/transmission-rss
#    links:
#      - transmission
#    environment:
#      - RSS_URL=http://.../xxxxx.rss

secrets:
  transmission_vpn_username:
    external: true
  transmission_vpn_password:
    external: true
