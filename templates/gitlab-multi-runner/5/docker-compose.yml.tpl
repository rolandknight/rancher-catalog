version: '2'

services:

  gitlab-runner-config:
    image: gitlab/gitlab-runner:alpine-v10.7.0
    stdin_open: true
    volumes:
    - /etc/gitlab-runner/
    tty: true
    command:
    - register
    - -n
    - --url
    - ${GITLAB_URL}
    - --registration-token
    - ${GITLAB_TOKEN}
    - --tag-list
    - ${GITLAB_TAGS}
    - --executor
    - docker
    - --description
    - Rancher Docker Runner
    - --docker-image
    - docker:latest
    - --docker-volumes
    - /var/run/docker.sock:/var/run/docker.sock
    - --docker-volumes
    - /var/binrepo:/var/binrepo
    - --docker-privileged
    labels:
      io.rancher.container.start_once: 'true'

  gitlab-runner:
    image: gitlab/gitlab-runner:alpine-v10.7.0
    stdin_open: true
    volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    tty: true
    volumes_from:
    - gitlab-runner-config
    entrypoint: /usr/bin/gitlab-runner{{- if eq .Values.debug "true"}} --debug{{- end}} run --user=gitlab-runner --working-directory=/home/gitlab-runner
    labels:
      io.rancher.sidekicks: gitlab-runner-config
      io.rancher.scheduler.global: 'true'
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
