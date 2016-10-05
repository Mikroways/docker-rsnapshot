#!/bin/sh
#
IFS=$'\n'
for backup in $BACKUP_DIRECTORIES; do
        echo "backup	$backup" >> /etc/rsnapshot.conf
done

exec "$@"
