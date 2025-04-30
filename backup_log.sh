#!/bin/bash

# This script backs up the log files by compressing them into a tar.gz file.

DIR="/home/wordpress/log"

# Get the current date in YYYY-MM-DD format
DATE=$(date +%Y-%m-%d)

# Compress the log file into a tar.gz file
tar -czf "$DIR/backup_sites_$DATE.tar.gz" "$DIR/backup_sites.log"

# afterwards, delete the log file
rm -f "$DIR/backup_sites.log"
