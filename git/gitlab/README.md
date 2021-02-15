# GitLab scripts

## Start instance

Use [docker-compose.yml](./docker-compose.yml) to start a GitLab instance

```bash
docker-compose up -d
```

## Start runner

This script will start a GitLab runner in docker container and
container name will be `gitlab-runner-$tag`. The `tag` is a random alphanumeric string.

```
./start_runner.sh <instance-url> <registration-token> [desc] [tags]

runner volume: /srv/gitlab_runner_config_3BrGU3pB
runner desc: docker runner
runner tags: docker,3BrGU3pB
Runtime platform                                    arch=amd64 os=linux pid=6 revision=943fc252 version=13.7.0
Running in system-mode.                            
                                                   
Registering runner... succeeded                     runner=qCA5qGLj
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 
a421d54ed94da0def3394a7590ce253fc28a805506748ce54c5335b1bad7d734
```

## Remove runner

This script can remove container and volume using `tag` in start runner step.

```bash
./remove_runner.sh <tag>

confirm remove container[gitlab-runner-h1l05Y] and volume[/srv/gitlab_runner_config_h1l05Y]? (y/n)y
gitlab-runner-h1l05Y
```
