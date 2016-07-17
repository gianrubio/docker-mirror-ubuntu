#!/bin/bash -x

FILE=/wait/done
while true
do
    apt-mirror
    touch $FILE
    echo "Created wait_file $FILE."
    sleep 7200
done