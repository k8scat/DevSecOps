#!/bin/bash

random_str=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
if [ -z "${random_str}" ];then
	echo "generate random str err"
	exit 1
fi
random_volume_dir="/srv/gitlab_runner_config_${random_str}"
echo "runner volume: ${random_volume_dir}"

# url=https://git.cloudevops.cn
url=$1
token=$2
if [ -z "${url}" ] || [ -z "${token}" ];then
  echo "usage: $0 <instance-url> <registration-token> [desc] [tags]"
  exit 1
fi

desc=$3
if [ -z "${desc}" ];then
  desc="docker runner"
fi
echo "runner desc: ${desc}"

tags=$4
if [ -z "${tags}" ];then
  tags="docker,${random_str}"
else
	tags="${tags},${random_str}"
fi
echo "runner tags: ${tags}"

# Registering Runner and generate config
# access-level: https://docs.gitlab.com/runner/register/index.html#docker
docker run --rm -v ${random_volume_dir}:/etc/gitlab-runner gitlab/gitlab-runner register \
--non-interactive \
--executor "docker" \
--docker-image alpine:latest \
--url "${url}" \
--registration-token "${token}" \
--description "${desc}" \
--tag-list "${tags}" \
--run-untagged="true" \
--locked="false" \
--access-level="not_protected"

container_name="gitlab-runner-${random_str}"
# Start runner
docker run -d --name ${container_name} --restart always \
-v ${random_volume_dir}:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest
echo "runner container: ${container_name}"
