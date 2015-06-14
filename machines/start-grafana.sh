#!/bin/bash
#
sudo docker run -d \
  -v $(pwd)/logs:/var/log/supervisor \
  -p 8080:80 \
  -p 8125:8125/udp \
  -p 8126:8126 --name grafana  kamon/grafana_graphite
