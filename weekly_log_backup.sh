#!/bin/bash

#declaring the variables
LOGDIR="${1:-/var/log}"
BACKUPDIR="${2:-/var/backups/logs}"
RETENTION_DAYS=7
TIMESTAMP=$(date +%F_%H%M%S)
OUTFILE="$BACKUPDIR/logs_backup_$TIMESTAMP.tar.gz"

#creating directory for backup file if it doesn't exists
mkdir -p "$BACKUPDIR"

#going into the log directory and create a gzipped tar of everything and save as OUTFILE
tar -czf "$OUTFILE" -C "$LOGDIR"

#logging
if [ $? -eq 0 ]; then
	echo "$(date -Iseconds) Backup OK: $OUTFILE" >> /var/log/automation/log_backup.log
else
	echo "$(date -Iseconds) Backup FAIL" >> /var/log/automation/log_backup.log
	exit 1
fi

#removing backups older than 15 days 
find "$BACKUPDIR" -type f -name 'logs_backup_*.tar.gz' -mtime +"$RETENTION_DAYS" -exec rm -f {} \;


