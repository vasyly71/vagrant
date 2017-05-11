#!/bin/bash

docker run --rm --name ucp \
	-v /var/run/docker.sock:/var/run/docker.sock \
	docker/ucp install \
	--host-address 192.168.51.10 \
	--admin-username admin \
	--admin-password admin123 2>&1 tee ~/install_ucp.log