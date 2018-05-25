# GitLab CE

GitLab CE is a free alternative to GitHub

Stack based on official GitLab version: latest

https://hub.docker.com/r/gitlab/gitlab-ce/


home2 config:

/etc/gitlab/gitlab.rb:
external_url 'https://gitlab.ionpig.com'
gitlab_rails['gitlab_shell_ssh_port'] = 222
registry_external_url 'https://gitlab.ionpig.com:5005'
registry['log_directory'] = "/var/log/gitlab/registry"
registry['log_level'] = "debug"
nginx['listen_port'] = 80
nginx['listen_https'] = false

traefik labels:
io.rancher.sidekicks=traefik-acme
io.rancher.scheduler.global=true
io.rancher.container.hostname_override=container_name
io.rancher.scheduler.affinity:host_label=traefik_lb=true

traefik ports:
80 -> 80
443 -> 443
8000 -> 8000

gitlab labels:
traefik.port=80
traefik.frontend.rule=Host:gitlab.ionpig.com
traefik.enable=true
io.rancher.container.hostname_override=container_name

gitlab ports:
222 -> 22
5005 -> 5005
8008 -> 80
