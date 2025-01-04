FROM docker.io/tofran/restic-rclone:0.17.0_1.68.2

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod o+x /docker-entrypoint.sh

RUN apk update && apk add mysql-client

ENTRYPOINT [ "/docker-entrypoint.sh" ]