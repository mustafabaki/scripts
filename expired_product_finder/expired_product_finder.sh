#!/bin/bash

# this script finds the expired products in the given text file and also notifies the user about 

# the products that are about to expire ...

# the "products" file has to be in the form of product_name\tExpiration_date

# get the products line by line first ...

while read line; do
	# skip if the line is blank

	if [ -z "$line" ]; then
		continue
	fi

	#extract names and the expiration dates ...
	name=$(echo "$line" | cut -d "	" -f 1)
	date=$(echo "$line" | cut -d "	" -f 2)
	
	# convert the date to year-month-day format
	year=$(echo "$date" | cut -d "-" -f 3)
	month=$(echo "$date" | cut -d "-" -f 2)
	day=$(echo "$date" | cut -d "-" -f 1)
	converted="$year$month$day"
	
	#calculate the date difference in days ...
	remaining=$(echo $(( ($(date --date="$converted" +%s) - $(date +%s) )/(60*60*24))))
	(( remaining = remaining+1 ))
	
	# check if the remaining days are less than 40 days ...

	if (( $remaining < 40 )); then
		echo "$name	: $remaining day(s)"
	fi
done < products
