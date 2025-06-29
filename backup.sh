#!/bin/bash

# Backup server
BACKUP=/home/backups
SSH_KEY="~/.ssh/backup"

# Config files
apache2=/etc/apache2
nginx=/etc/nginx
phpmyadmin=/etc/phpmyadmin
php=/etc/php
mysql=/etc/mysql
varnish=/etc/varnish
redis=/etc/redis
ufw=/etc/ufw
fail2ban=/etc/fail2ban

# Backuping config files
echo "Backuping config files"
declare -a configs=($phpmyadmin $php $mysql $apache2 $nginx $varnish $redis $ufw $fail2ban)

# loop through the array and backup the files in the directories
for dir in "${configs[@]}"; do
	echo $dir
	rsync -av -e "ssh -i $SSH_KEY" $dir backups@194.164.60.10:$BACKUP
done

# Backuping users files
echo "Backuping users files"
declare -a users=("/root" "/home/wordpress")

# loop through the array and backup the home directories
for user in "${users[@]}"; do
	# see https://stackoverflow.com/a/3294102/12935487
	echo ${user##*/}
	rsync -av -e "ssh -i $SSH_KEY" $user/* backups@194.164.60.10:$BACKUP/${user##*/}
done

# Backuping log files
# echo "Backuping log files"
declare -a logs=("/home/wordpress/log" "/var/log")

# loop through the array and backup the log files
for log in "${logs[@]}"; do
	echo $log
	rsync -av -e "ssh -i $SSH_KEY" $logs/* backups@194.164.60.10:$BACKUP/log
done
