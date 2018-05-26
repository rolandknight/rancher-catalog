version: '2'
services:
  artifactory:
    {{- if eq .Values.ARTIFACTORY_VERSION "OSS"}}
    image: docker.bintray.io/jfrog/artifactory-oss:5.10.3
    {{- else}}
    image: docker.bintray.io/jfrog/artifactory-pro:5.10.3
    {{- end}}
    volumes:
     - artifactory-data:/var/opt/jfrog/artifactory
    environment:
     - EXTRA_JAVA_OPTIONS=${EXTRA_JAVA_OPTIONS}
volumes:
  artifactory-data:
    driver: ${VOLUME_DRIVER}

