version: '2'

services:
  autossh:
    image: gitlab.ionpig.com:5005/github.com/docker-autossh
    stdin_open: true
    environment:
      - SSH_HOSTUSER=${SSH_HOSTUSER}
      - SSH_HOSTNAME=${SSH_HOSTNAME}
      - SSH_BIND_ADDRESS=${SSH_BIND_ADDRESS}
      - SSH_TUNNEL_REMOTE=${SSH_TUNNEL_REMOTE}
      - SSH_TUNNEL_HOST=${SSH_TUNNEL_HOST}
      - SSH_TUNNEL_LOCAL=${SSH_TUNNEL_LOCAL}
      - SSH_MODE=${SSH_MODE}
      - SSH_HOST_PORT=${SSH_HOST_PORT}
    restart: always
# expose port on host if FQDN not specified (otherwise available via Traefik only)
{{- if eq .Values.FQDN ""}}
    network_mode: "host"
{{- end}}
    volumes:
     - ${DOT_SSH_DIR}:/data/.ssh
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.FQDN ""}}
      traefik.enable: true
      traefik.port: ${SSH_TUNNEL_REMOTE}
      traefik.frontend.rule: "Host:${FQDN}"
{{- end}}
    dns:
     - 1.1.1.1
     - 1.0.0.1
