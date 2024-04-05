version: '2'

services:
  omnidb:
    image: 'sorrell/alpine-omnidb'
    ports:
      - '${PORT}:9000/tcp'
