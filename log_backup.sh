#!/bin/bash

#declaring the variables
LOGDIR=/home/dibyagiri/syslogs
BACKUPDIR=/home/dibyagiri/syslogs/backup
RETENTION_DAYS=15
TIMESTAMP=$(date +%F_%H%M%S)

#creating directory for backup file if it doesn't exists
mkdir -p "$BACKUPDIR"
OUTFILE="$BACKUPDIR/logs_backup_$TIMESTAMP.tar.gz"

#going into the log directory and create a gzipped tar of all the log files and save as OUTFILE
cd "$LOGDIR"
tar -czf "$OUTFILE" ./*.log

#removing backups older than 15 days 
find "$BACKUPDIR" -type f -name 'logs_backup_*.tar.gz' -mtime +"$RETENTION_DAYS" -exec rm -f {} \;


