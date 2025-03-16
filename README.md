# Distributed Minecraft Server Proj
## *Importante*
Creare un server.env all'interno della directory env/ contenente `IP_SERVER=<IP_Utente_ZeroTier>`
e sostituire IP_Utente_ZeroTier con il proprio nella rete ZeroTier

### Avviare il server con run_server (che comprende anche docker compose up --build)
`./run-server.sh`

### Avviare la RCON-cli del server mc
`docker exec -it theboys rcon-cli`

### Status Lock mutex su mysql
```
MYSQL_PWD="1888a3bdbe69d4c1bfb95e0f306c05bfdde425cf" mysql -u "test_eightgray" -P 3305 -h "ajv81.h.filess.io" "test_eightgray" -sN -e "SELECT connection FROM mutex";
```

### Unlock mutex su mysql
```
MYSQL_PWD="1888a3bdbe69d4c1bfb95e0f306c05bfdde425cf" mysql -u "test_eightgray" -P 3305 -h "ajv81.h.filess.io" "test_eightgray" -sN -e "UPDATE mutex SET connection = 0 WHERE connection = 1";
```
`./utils/db.sh status`
`./utils/db.sh unlock`

### Unlock restic repo su MEGA
`./utils/unlock-repo.sh`

### Avviare backup manuale
`docker compose exec backups backup now`

### Lista Restic Snapshots
`restic -r rclone:mega:/cobblemon-bkps snapshots`

### Oppure su WSL
```
docker run --rm -e RESTIC_HOSTNAME="Mondo" \
           -e RESTIC_PASSWORD=minecraft \
           -e RESTIC_REPOSITORY="rclone:mega:/cobblemon-bkps" \
           -v server:/data \
           -v ./rclone.conf:/root/.config/rclone/rclone.conf \
           --network default \
           docker.io/tofran/restic-rclone:0.17.0_1.68.2  -r rclone:mega:/cobblemon-bkps snapshots
```

### Ripristino Restic Snapshot
`restic -r rclone:mega:/cobblemon-bkps restore SNAPSHOT_ID --target / --host Mondo --no-lock`

### id rete ZeroTier
`9f77fc393ecb9ae7`

### DDNS IP
`unimemc.duckdns.org`

### DDNS test
`nslookup unimemc.duckdns.org`
### DDNS test esplicito Google DNS
`nslookup unimemc.duckdns.org 8.8.8.8`
### DDNS test esplicito CloudFlare
`nslookup unimemc.duckdns.org 1.1.1.1`

### Percorso WSL del mondo nel volume docker - non più usato -
`\\wsl.localhost\docker-desktop\mnt\docker-desktop-disk\data\docker\volumes\server\_data`

## ------------------------- WSL Requirements -------------------
`sudo apt install mysql-client`

`sudo apt install restic`

`sudo apt install rclone`
