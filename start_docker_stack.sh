#!/bin/sh
docker-compose up --build -d
docker image prune --all --force