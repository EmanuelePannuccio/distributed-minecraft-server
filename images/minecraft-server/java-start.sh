#!/bin/bash -xe

. "${SCRIPTS:-/}start-utils"

check_or_wait_lock() {
  echo "Checking existing or stale lock.."
  while [ $(restic -r rclone:mega:/backups list locks | wc -l) -gt 0 ]; do
    echo "Waiting 10s for unlocking repo -" $(restic -r rclone:mega:/backups list locks | wc -l) "1"
    sleep 10s
  done
}

cleanup() {
  check_or_wait_lock
  echo "Container stopped, performing backup..."
  echo "Backup starting"
  
  mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "UPDATE mutex SET connection = 0 WHERE connection = 1"
  restic -r rclone:mega:/backups forget --keep-last 5 --prune
  restic backup -r rclone:mega:/backups --tag mc_backups --tag $RESTIC_TAG -vv --host Mondo /data/world
  
  echo "Backup end"
  exit 0
}

trap 'cleanup' 0

check_or_wait_lock

if [[ $(mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "SELECT connection FROM mutex WHERE connection = 0 LIMIT 1") ]]; then 
  mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "UPDATE mutex SET connection = 1 WHERE connection = 0"
  echo "Aggiornamento IP: $IP_SERVER"
  curl -s -o /dev/null -w "%{http_code}"  "https://www.duckdns.org/update?domains=unimemc&token=$DUCKDNS_TOKEN&ip=$IP_SERVER"
else 
  echo "server già avviato, non disponibile"
  exit 1
fi

mc-server-runner $@ &

wait $!