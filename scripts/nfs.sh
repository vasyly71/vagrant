#!/bin/sh -eux

yum -y install nfs-utils

setsebool -P nfs_export_all_rw 1

systemctl enable nfs-server.service
systemctl start nfs-server.service

mkdir /var/nfs
mkdir /var/nfs/share_1
mkdir /var/nfs/share_2
mkdir /var/nfs/share_3
mkdir /var/nfs/share_4
mkdir /var/nfs/share_5


chown nfsnobody:nfsnobody /var/nfs
chmod 755 /var/nfs

echo "/var/nfs/share_1	*(rw,sync,no_subtree_check)" >> /etc/exports
echo "/var/nfs/share_2	*(rw,sync,no_subtree_check)" >> /etc/exports
echo "/var/nfs/share_3	*(rw,sync,no_subtree_check)" >> /etc/exports
echo "/var/nfs/share_4	*(rw,sync,no_subtree_check)" >> /etc/exports
echo "/var/nfs/share_5	*(rw,sync,no_subtree_check)" >> /etc/exports

exportfs -a
