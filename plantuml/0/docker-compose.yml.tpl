version: '2'

services:
  plantuml:
    image: plantuml/plantuml-server:jetty
    ports:
    - ${PORT}:8080/tcp
