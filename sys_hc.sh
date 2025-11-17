#!/bin/bash
#script for system health check, to be run every minute

#definging path to write logs
OUTLOG=/home/dibyagiri/syslogs/system_healt.log

#defining threshold values
CPU_THRESH=80
MEM_THRESH=80
DISK_THRESH=85

timestamp() { date -Iseconds }

CPU=$(top -bn1 | awk '/CPU/ {print 100 -$8}')
MEM=$(free | awk '/Mem:/ {print $3/$2 * 100}')
DISK=$(df / | awk 'END{print $5}' | tr -d '%')


echo "$(timestamp) CPU:${CPU}% MEM:${MEM}% DISK:${DISK}%" >> "$OUTLOG"

awk -v c="$CPU" -v m="$MEM" -v d="$DISK" -v t="$(timestamp)" \
    -v cpu_t="$CPU_THRESH" -v mem_t="$MEM_THRESH" -v disk_t="$DISK_THRESH" '
BEGIN {
  if (c+0 > cpu_t+0)  print t " ALERT CPU "  c "%";
  if (m+0 > mem_t+0)  print t " ALERT MEM "  m "%";
  if (d+0 > disk_t+0) print t " ALERT DISK " d "%";
}' >> "$OUTLOG"
