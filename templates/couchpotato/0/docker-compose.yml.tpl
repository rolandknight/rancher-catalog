version: '2'
volumes:
  couchpotato-config:
    driver: ${volumedriver}
services:
  app:
    restart: always
    image: linuxserver/couchpotato:latest
    container_name: couchpotato
#    ports:
#     - "5050"
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=America/Toronto
      - UMASK_SET=022
    volumes:
    - /mnt/vol01/media/movies:/movies
    - /mnt/vol01/transmission/completed:/downloads
    - couchpotato-config:/config
    labels:
      io.rancher.container.pull_image: always
      depot.lb.link: true
      depot.app.type: couchpotato
      traefik.enable: true
      traefik.port: 5050
      traefik.frontend.rule: Host:${APP_HOSTNAME}
      io.rancher.container.hostname_override: container_name
