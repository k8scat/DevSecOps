#!/bin/bash

# url=https://git.cloudevops.cn
url=$1
token=$2
if [ -z "${url}" ] || [ -z "${token}" ];then
  echo "usage: $0 <instance-url> <registration-token> [desc] [tags]"
  exit 1
fi

desc=$3
if [ -z "${desc}" ];then
  tags="docker runner"
fi

tags=$4
if [ -z "${tags}" ];then
  tags="docker"
fi

# Registering Runner and generate config
# access-level: https://docs.gitlab.com/runner/register/index.html#docker
docker run --rm -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
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

# Start runner
docker run -d --name gitlab-runner --restart always \
-v /srv/gitlab-runner/config:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest
