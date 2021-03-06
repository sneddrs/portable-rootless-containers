#!/usr/bin/bash

BASE_DIR="~/.containers"

set -o noclobber

mkdir -p ${BASE_DIR}/install
mkdir -p ${HOME}/.config/containers/
cd ${BASE_DIR}/install

curl http://mirror.centos.org/centos/7/extras/x86_64/Packages/fuse3-libs-3.6.1-4.el7.x86_64.rpm -O
curl http://mirror.centos.org/centos/7/extras/x86_64/Packages/fuse-overlayfs-0.7.2-6.el7_8.x86_64.rpm -O
curl http://mirror.centos.org/centos/7/extras/x86_64/Packages/slirp4netns-0.4.3-4.el7_8.x86_64.rpm -O
curl http://mirror.centos.org/centos/7/extras/x86_64/Packages/conmon-2.0.8-1.el7.x86_64.rpm -O
curl http://mirror.centos.org/centos/7/extras/x86_64/Packages/podman-1.6.4-18.el7_8.x86_64.rpm -O
curl http://mirror.centos.org/centos/7/extras/x86_64/Packages/buildah-1.11.6-11.el7_8.x86_64.rpm -O
curl https://yum.oracle.com/repo/OracleLinux/OL7/developer/x86_64/getPackage/runc-1.0.0-65.rc8.el7.x86_64.rpm -O
curl https://yum.oracle.com/repo/OracleLinux/OL7/addons/x86_64/getPackage/containers-common-0.1.37-3.0.1.el7.x86_64.rpm -O

cd ${BASE_DIR}

rpm2cpio ${BASE_DIR}/install/slirp4netns-0.4.3-4.el7_8.x86_64.rpm | cpio -idmv
rpm2cpio ${BASE_DIR}/install/fuse3-libs-3.6.1-4.el7.x86_64.rpm | cpio -idmv
rpm2cpio ${BASE_DIR}/install/fuse-overlayfs-0.7.2-6.el7_8.x86_64.rpm | cpio -idmv
rpm2cpio ${BASE_DIR}/install/conmon-2.0.8-1.el7.x86_64.rpm | cpio -idmv
rpm2cpio ${BASE_DIR}/install/podman-1.6.4-18.el7_8.x86_64.rpm | cpio -idmv
rpm2cpio ${BASE_DIR}/install/runc-1.0.0-65.rc8.el7.x86_64.rpm | cpio -idmv
rpm2cpio ${BASE_DIR}/install/containers-common-0.1.37-3.0.1.el7.x86_64.rpm | cpio -idmv

cp ${BASE_DIR}/etc/containers/registries.conf ~/.config/containers/
cp ${BASE_DIR}/etc/containers/policy.json ~/.config/containers/

rm -rf ${BASE_DIR}/install

export PATH=$PATH:~/.containers/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.containers/usr/lib64/

. ${BASE_DIR}/setEnv.sh
