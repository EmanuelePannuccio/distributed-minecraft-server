# Distributed Minecraft Server Proj
## Importante
Ricordarsi di creare un server.env all'interno della cartella env contenente `IP_SERVER=<IP_Utente_ZeroTier>`

### Avviare il server comprendendo il docker compose up --build
`./run-server.sh`

### Avviare la RCON-cli del server mc
`docker exec -it theboys rcon-cli`

### Avviare backup manuale
`docker compose exec backups backup now`

### Lista Restic Snapshots
`restic -r rclone:mega:/backups snapshots`

### Oppure su WSL
```
docker run --rm -e RESTIC_HOSTNAME="Mondo" \
           -e RESTIC_PASSWORD=minecraft \
           -e RESTIC_REPOSITORY="rclone:mega:/backups" \
           -v server:/data \
           -v ./rclone.conf:/root/.config/rclone/rclone.conf \
           --network default \
           docker.io/tofran/restic-rclone:0.17.0_1.68.2  -r rclone:mega:/backups snapshots
```

### Ripristino Restic Snapshot
`restic -r rclone:mega:/backups restore SNAPSHOT_ID --target / --host Mondo --no-lock`

### id rete ZeroTier
`9f77fc393ecb9ae7`

### DDNS IP
`unimemc.duckdns.org`

### DDNS test
`nslookup unimemc.duckdns.org`
### DDNS test esplicito
`nslookup unimemc.duckdns.org 8.8.8.8`

### Percorso WSL del mondo nel volume docker
`\\wsl.localhost\docker-desktop\mnt\docker-desktop-disk\data\docker\volumes\server\_data`

## ------------------------- WSL Requirements -------------------
`sudo apt  install mysql-client`

`sudo apt  install restic`

`sudo apt  install rclone`
