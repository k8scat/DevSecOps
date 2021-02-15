#!/bin/bash

tag=$1
if [ -z "${tag}" ];then
	echo "usage: $0 <tag>"
	exit 1
fi

container_name="gitlab-runner-${tag}"
volume_dir="/srv/gitlab_runner_config_${tag}"
read -p "confirm remove container[${container_name}] and volume[${volume_dir}]? (y/n): " result

if [ "${result}" = "y" ];then
	docker rm -f ${container_name}
	rm -rf ${volume_dir}
fi
