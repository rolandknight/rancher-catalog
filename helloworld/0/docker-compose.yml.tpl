version: "2"
services:
  helloworld:
    image: gitlab.ionpig.com:5005/roland.knight/helloworld
    labels:
      traefik.enable: true
      traefik.port: 80
      traefik.frontend.rule: "Host:${FQDN}"
