#!/bin/sh -eux

CDIR=`pwd`
docker volume create ucp-controller-server-certs

mkdir ~/certs
cd ~/certs

openssl req -x509 -nodes -newkey rsa:4096 -keyout key.pem -out ca.pem -days 365 -subj "/CN=ucp.sigma-systems.com"
openssl req -key key.pem -new -out server.req -subj "/CN=ucp.sigma-systems.com"
echo "00" > file.srl
openssl x509 -req -in server.req -CA ca.pem -CAkey key.pem -CAserial file.srl -out cert.pem

cp ~/certs/ca.pem /var/lib/docker/volumes/ucp-controller-server-certs/_data/
cp ~/certs/cert.pem /var/lib/docker/volumes/ucp-controller-server-certs/_data/
cp ~/certs/key.pem /var/lib/docker/volumes/ucp-controller-server-certs/_data/

cd $CDIR
