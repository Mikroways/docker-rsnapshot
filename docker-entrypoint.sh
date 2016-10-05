#!/bin/sh
#
# A helper script for ENTRYPOINT.
set -e

IFS=$'\n'
if [ "$1" = 'rsnapshot' ]; then
  for backup in $BACKUP_DIRECTORIES; do
    echo "backup	$backup" >> /etc/rsnapshot.conf
  done
fi

exec "$@"
