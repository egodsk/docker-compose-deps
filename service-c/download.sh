#!/usr/bin/env sh
mkdir -p dev-env

# Copy the deps docker-compose files
docker cp $(docker create --rm $(docker build -f Dockerfile.deps -q .)):/dev-env ./
