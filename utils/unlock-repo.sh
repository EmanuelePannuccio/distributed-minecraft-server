#!/bin/bash

export RCLONE_CONFIG="$(pwd)/rclone.conf"
restic -r rclone:mega:/backups unlock --remove-all