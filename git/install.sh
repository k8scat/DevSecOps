#!/bin/bash
#
# For CentOS 7, install git from source code, refer to https://github.com/git/git/blob/master/INSTALL
#
# You can download the git tar file previously, then install with the git version you downloaded.
#

# Get version from https://github.com/git/git/releases, for example: 2.29.2
version=$1
if [ -z "${version}" ];then
	echo "usage: $0 <git-version>"
	exit 1
fi

if [ $(id -u) != 0 ];then
	echo "require sudo permission"
	exit 1
fi

yum install -y gcc openssl-devel expat-devel curl-devel

if [ ! -f "v${version}.tar.gz" ];then
	echo "v${version}.tar.gz not found, try to download..."
	wget https://github.com/git/git/archive/v${version}.tar.gz
else
	echo "v${version}.tar.gz found"
fi
tar zxf v${version}.tar.gz
cd git-${version}
make prefix=/usr
make prefix=/usr install
