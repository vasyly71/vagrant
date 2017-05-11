#!/bin/bash

if [ -z "$1" ]
then
    echo "Please provide nfs server IP address as parameter!"
    exit 1
fi

NFS_SERVER=$1

for mp in `showmount --no-headers -e $NFS_SERVER | sed 's/ .*//'`
do
        echo Setup $mp
        mkdir -p $mp
        FSTAB_COUNT=`grep "$NFS_SERVER:$mp" /etc/fstab | wc -l`
        if [ $FSTAB_COUNT -eq "0" ]
        then
        	mount $NFS_SERVER:$mp $mp
                echo  "$NFS_SERVER:$mp  $mp nfs rw,sync,hard,intr  0  0" >> /etc/fstab
        else
                echo "$NFS_SERVER:$mp already in /etc/fstab"
        fi

done
