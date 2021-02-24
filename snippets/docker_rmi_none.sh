#!/bin/bash

docker rmi `docker images | grep '<none>' | grep -v grep | awk '{print $3}'`
