#!/bin/bash

export MYSQL_PWD="1888a3bdbe69d4c1bfb95e0f306c05bfdde425cf"

MYSQL_USERNAME=test_eightgray
MYSQL_DB=test_eightgray
MYSQL_HOST=ajv81.h.filess.io
MYSQL_PORT=3305

case $1 in
    "lock")
        mysql -u test_eightgray -P 3305 -h ajv81.h.filess.io test_eightgray -sN -e 'UPDATE mutex SET connection = 1 WHERE connection = 0';
        echo "DB STATUS:" $(mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "SELECT connection FROM mutex WHERE connection = 1 LIMIT 1");;
    "unlock")
        mysql -u test_eightgray -P 3305 -h ajv81.h.filess.io test_eightgray -sN -e 'UPDATE mutex SET connection = 0 WHERE connection = 1';
        echo "DB STATUS:" $(mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "SELECT connection FROM mutex WHERE connection = 0 LIMIT 1");;
    "check")
        echo $(mysql -u "$MYSQL_USERNAME" -P $MYSQL_PORT -h "$MYSQL_HOST" $MYSQL_DB -sN -e "SELECT connection FROM mutex WHERE connection = 0 LIMIT 1");;
    *)
        echo "Unknown command: $1" ;;
esac
