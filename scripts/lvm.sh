#!/bin/sh -eux

old_name=`vgdisplay -c | sed "s/\:.*//" | sed "s/\s*//"`
new_name=VolGrp001

vgrename -v $old_name $new_name;
sed -i "s/\/${old_name}-/\/${new_name}-/g" /etc/fstab;
sed -i "s/\([/=]\)${old_name}\([-/]\)/\1${new_name}\2/g" /boot/grub2/grub.cfg;
sed -i "s/\([/=]\)${old_name}\([-/]\)/\1${new_name}\2/g" /etc/default/grub;

mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)