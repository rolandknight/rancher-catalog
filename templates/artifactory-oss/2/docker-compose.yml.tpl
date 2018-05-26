version: '2'
services:
  artifactory:
    {{- if eq .Values.ARTIFACTORY_VERSION "OSS"}}
    image: docker.bintray.io/jfrog/artifactory-oss:6.0.1
    {{- else}}
    image: docker.bintray.io/jfrog/artifactory-pro:6.0.1
    {{- end}}
    volumes:
     - artifactory-data:/var/opt/jfrog/artifactory
    environment:
     - EXTRA_JAVA_OPTIONS=${EXTRA_JAVA_OPTIONS}
    labels:
      io.rancher.container.hostname_override: container_name
      traefik.enable: true
      traefik.port: 8081
      traefik.frontend.rule: "Host:${FQDN},docker.${FQDN}"
volumes:
  artifactory-data:
    driver: ${VOLUME_DRIVER}

