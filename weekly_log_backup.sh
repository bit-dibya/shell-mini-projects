#!/bin/bash

#declaring the variables
LOGDIR="${1:-/var/log}"
BACKUPDIR="${2:-/var/backups/logs}"
RETENTION_DAYS=7
TIMESTAMP=$(date +%F_%H%M%S)
OUTFILE="$BACKUPDIR/logs_backup_$TIMESTAMP.tar.gz"
