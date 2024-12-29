#!/bin/bash

if [[ $(docker volume ls | grep server | wc -l ) -eq 0 ]]; then
    docker volume create server &> /dev/null
fi

check_backup() {
  while true; do
    read -p "Do you want to backup the current Minecraft world? (y/n): " user_input
    case "$user_input" in
      y|Y)
        echo "You chose to backup the Minecraft world."
        return 0
        ;;
      n|N)
        echo "You chose not to backup the Minecraft world."
        return 1
        ;;
      *)
        echo "Invalid input. Please enter 'y' for yes or 'n' for no."
        ;;
    esac
  done
}

check_backup

if [[ $? -eq 0 ]]; then
  echo "Proceeding with the backup..."
  bash $(pwd)/utils/backup-world-offline.sh
else
  echo "Skipping backup world."
fi

docker compose up --build
