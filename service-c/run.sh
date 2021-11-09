#!/usr/bin/env sh
MANIFESTS=' '
for dockerfile in $PWD/dev-env/*
do
    MANIFESTS="${MANIFESTS} -f $dockerfile"
done

docker-compose -p service-c $MANIFESTS -f docker-compose.yml up -d