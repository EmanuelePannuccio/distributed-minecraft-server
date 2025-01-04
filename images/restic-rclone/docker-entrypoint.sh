#!/bin/sh

echo "Checking stale locks"

while [ $(mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "SELECT connection FROM mutex WHERE connection = 1 LIMIT 1" | wc -l) -gt 0 ]; do
    echo "Waiting 10s for unlocking Mutex Minecraft World.."
    sleep 10s
done

while [ $(restic -r rclone:mega:/backups list locks | wc -l) -gt 0 ]; do
    echo "Waiting 10s for unlocking repo -" $(restic -r rclone:mega:/backups list locks | wc -l) "1"
    sleep 10s
done

restic -r rclone:mega:/backups restore latest --target / --host Mondo