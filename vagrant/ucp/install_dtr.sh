#!/bin/bash

docker pull docker/dtr:2.2.4

docker run -it --rm   
	docker/dtr:2.2.4 install   \
	--ucp-node  ucp01.docker.vm \
	--replica-http-port 8080 \
	--replica-https-port 8443 \
	--ucp-username admin \
	--ucp-password admin123 \
	--ucp-url https://192.168.51.10 \
	--ucp-insecure-tls \
	--dtr-external-url  https://192.168.51.10:8443