FROM itzg/minecraft-server

RUN apt-get update && apt-get install restic mysql-client curl -y && rm -rf /var/lib/apt/lists/*
RUN curl https://rclone.org/install.sh | bash

COPY --chown=root:root start-finalExec /start-finalExec
COPY --chown=root:root java-start.sh /java-start.sh

RUN chmod 777 -R /start-finalExec
RUN chmod 777 -R /java-start.sh

