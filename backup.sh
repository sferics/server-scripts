#!/bin/bash

# Backup server
BACKUP=/home/backups/metz
SSH_KEY="~/.ssh/backup"

# Config files
apache2=/etc/apache2
phpmyadmin=/etc/phpmyadmin
php=/etc/php
mysql=/etc/mysql

# Backuping config files
echo "Backuping config files"
declare -a configs=($phpmyadmin $php $mysql $apache2)

# loop through the array and backup the files in the directories
for dir in "${configs[@]}"; do
	echo $dir
	rsync -av -e "ssh -i $SSH_KEY" $dir backups@194.164.60.10:$BACKUP
done

# Backuping users files
echo "Backuping users files"
declare -a users=("root" "/home/wordpress")

# loop through the array and backup the home directories
for user in "${users[@]}"; do
	# see https://stackoverflow.com/a/3294102/12935487
	echo ${user##*/}
	rsync -av -e "ssh -i $SSH_KEY" $user backups@194.164.60.10:$BACKUP/$user
done
