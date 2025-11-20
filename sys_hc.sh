#!/usr/bin/env bash

#defingng output log path
OUTLOG=/home/dibyagiri/syslogs/system_health.log

#defingin thersholds for cpu,memory and disk utilisation
CPU_THRESH=80
MEM_THRESH=80
DISK_THRESH=85


timestamp() {
  date -Iseconds
}

CPU=$(top -bn1 | awk -F'[, ]+' '/Cpu\(s\):/ {print 100 - $8}')    #extracting cpu utilisation from top
MEM=$(free | awk '/Mem:/ {print $3/$2 * 100}')    #extracting memory utilisation from free
DISK=$(df / | awk 'END{print $5}' | tr -d '%')    #extracting disk utilisation from df

#printing the utilisations
echo "$(timestamp) CPU:${CPU}% MEM:${MEM}% DISK:${DISK}%" >> "$OUTLOG"

#setting up alert
awk -v c="$CPU" -v m="$MEM" -v d="$DISK" -v t="$(timestamp)" \
    -v cpu_t="$CPU_THRESH" -v mem_t="$MEM_THRESH" -v disk_t="$DISK_THRESH" '
BEGIN {
  if (c+0 > cpu_t+0)  print t " ALERT CPU "  c "%";
  if (m+0 > mem_t+0)  print t " ALERT MEM "  m "%";
  if (d+0 > disk_t+0) print t " ALERT DISK " d "%";
}' >> "$OUTLOG"

