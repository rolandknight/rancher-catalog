version: '2'

services:
  rundeck:
    image: jordan/rundeck:2.11.1
    environment:
    - EXTERNAL_SERVER_URL=http://${FQDN}
    - RUNDECK_PASSWORD=rundeck
    labels:
      traefik.enable: true
      traefik.port: 4440
      traefik.frontend.rule: Host:${FQDN}
      io.rancher.container.hostname_override: container_name
#    healthcheck:
#      test: ["CMD", "curl", "-f", "http://localhost"]
#      interval: 1m30s
#      timeout: 10s
#      retries: 3
#      start_period: 30s
