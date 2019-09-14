#!/bin/bash

docker-compose down -v

docker rmi ntp

docker build -t ntp .
