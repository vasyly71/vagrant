#!/bin/sh -eux

rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"
yum install -y yum-utils
yum-config-manager --add-repo https://packages.docker.com/1.13/yum/repo/main/centos/7
yum makecache fast

# nfs utils required by docker netshare 
# nfs driver 
yum install -y nfs-utils

yum install -y docker-engine

systemctl enable docker.service
systemctl start docker.service

#Configure direct lvm
yum install -y lvm2
pvcreate /dev/sdb
vgcreate docker /dev/sdb
lvcreate --wipesignatures y -n thinpool docker -l 95%VG
lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG
lvconvert -y --zero n -c 512K --thinpool docker/thinpool --poolmetadata docker/thinpoolmeta

cat > /etc/lvm/profile/docker-thinpool.profile <<EOF
activation {
thin_pool_autoextend_threshold=80
thin_pool_autoextend_percent=20
}
EOF

lvchange --metadataprofile docker-thinpool docker/thinpool
lvs -o+seg_monitor

cat > /etc/docker/daemon.json <<EOF
{
  "storage-driver": "devicemapper",
   "storage-opts": [
     "dm.thinpooldev=/dev/mapper/docker-thinpool",
     "dm.use_deferred_removal=true",
     "dm.use_deferred_deletion=true"
   ]
}
EOF

systemctl daemon-reload
systemctl restart docker.service 

# Create user sigma that can use docker without sudo
useradd sigma
echo "sigma" | passwd --stdin sigma
usermod -aG docker sigma

# ====================================================================
# Install docker-compose its installation requires docker epel and pip
# ====================================================================
yum -y install epel-release
yum -y install python-pip
pip install docker-compose

# My License
# https://storebits.docker.com/ee/centos/sub-04aa1f97-9df6-4a12-8049-e9f1a93f50e4