#!/bin/bash
echo "Unlock repo Mega"

docker run --rm -e RESTIC_HOSTNAME="Mondo" \
           -e RESTIC_PASSWORD=minecraft \
           -e RESTIC_REPOSITORY="rclone:mega:/backups" \
           -v server:/data \
           -v ./rclone.conf:/root/.config/rclone/rclone.conf \
           --network default \
           docker.io/tofran/restic-rclone:0.17.0_1.68.2 -r rclone:mega:/backups unlock --remove-all

echo "Unlock repo Mega completed."