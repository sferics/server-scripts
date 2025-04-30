#!/bin/bash

declare -a sites=("metz metz-test metz-live")

for site in "${sites[@]}"; do
	
	# backup wordpress database using wpi cli and zip it
	wp db export --path=/var/www/html/$site - | gzip -9 - > ~/dbs/${site}_"$(date +'%Y-%m-%d_%H').sql.gz"
	
	# copy data in Server Root	
	cp -r /var/www/html/$site ~/sites/
done
