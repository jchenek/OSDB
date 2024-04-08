#!/bin/sh
#sh one-step-DB-download.sh <IN_path_to_OSDB>
#if download fail, directly rerun the scripts
echo "Path to OSDB: $1"
echo "Path to OSDB: $1" >> OSDB_Download.log
echo "OSDB pipeline p1 start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########cazy
echo "cazy start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir cazy
cd cazy
aria2c -c -i $1/DB_links/link_cazy.txt
cd ../
echo "cazy finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########cog
echo "cog start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir cog
cd cog
aria2c -c -i $1/DB_links/link_cog.txt
cd ../
echo "cog finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########tcdb
echo "tcdb start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir tcdb
cd tcdb
aria2c -c -i $1/DB_links/link_tcdb.txt
cd ../
echo "tcdb finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########merops
echo "merops start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir merops
cd merops
aria2c -c -i $1/DB_links/link_merops.txt
cd ../
echo "merops finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########swissprot
echo "swissprot start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir swissprot
cd swissprot
aria2c -c -i $1/DB_links/link_swissprot.txt
cd ../
echo "swissprot finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########pfam-A
echo "pfam-A start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir pfam-A
cd pfam-A
aria2c -c -i $1/DB_links/link_pfam-A.txt
cd ../
echo "pfam-A finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

########UniProtKB-TrEMBL
echo "UniProtKB-TrEMBL start at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) >> OSDB_Download.log
mkdir UniProtKB-TrEMBL
cd UniProtKB-TrEMBL
aria2c -c -i $1/DB_links/link_UniProtKB-TrEMBL.txt
cd ../
echo "UniProtKB-TrEMBL finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log

echo "OSDB pipeline p1 finish at:" >> OSDB_Download.log
echo $(date +%Y-%m-%d" "%H:%M:%S) "\n" >> OSDB_Download.log