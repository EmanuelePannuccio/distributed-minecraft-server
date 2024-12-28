#!/bin/bash

if [[ $(docker compose ps | grep theboys | wc -l) -gt 0 ]]; then
    echo "Spegni prima i container di minecraft per eseguire un backup offline"
    exit 1
fi

docker run --rm \
           -e RESTIC_HOSTNAME="Mondo" \
           -e RESTIC_PASSWORD=minecraft \
           -e RESTIC_REPOSITORY="rclone:mega:/backups" \
           -v server:/data \
           -v ./rclone.conf:/root/.config/rclone/rclone.conf \
           docker.io/tofran/restic-rclone:0.17.0_1.68.2 backup -r rclone:mega:/backups --tag mc_backups --tag siakoo -vv --host Mondo /data/world