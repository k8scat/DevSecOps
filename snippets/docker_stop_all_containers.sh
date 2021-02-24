#!/bin/bash

docker stop `docker ps | awk 'NR != 1 {print $1}'`
