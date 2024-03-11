#!/bin/sh
#sh one-step-DB-download.sh <IN_path_to_OSDB>

########nr
echo "nr start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir nr
cd nr
aria2c -i $1/DB_links/link_nr.txt
cd ../
echo "nr finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log
