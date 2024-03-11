OSDB (one-step database)
=======

OSDB is a pipeline for local database configuration.

- `Note 1`: Please check links in dir `DB_links` before run this pipeline. Make sure all links are valid.
- `Note 2`: It is common to face `403 forbidden` issues when you are running kegg-related scripts. Just terminate the current running scripts and re-run it again, and again, and again ... The scripts will not delete downloaded data. And finally you will successfully download them all :)
- `last update`: 2024/03/11

Installation
---------------

### Step 1. Create a conda environment
```sh
conda create -n OSDB -y
conda activate OSDB

#mamba is recommend
mamba install wget aria2 diamond -y
#or
conda install wget aria2 diamond -y
```

### Step 2. Download or clone OSDB repository
```sh
git clone https://github.com/jchenek/OSDB.git
```

Usage
-----

- `Step 1`: download general database
Will use aria2 to download all links (~24 h)
```sh
sh /PATH/TO/one-step-DB-download-p1-general.sh /PATH/TO/YOUR/OSDB_dir
```

- `Step 2`: download nr database
Will use aria2 to download nr links (~24 h)
```sh
sh /PATH/TO/one-step-DB-download-p2-nr.sh /PATH/TO/YOUR/OSDB_dir
```

- `Step 3`: download kegg database
Will use wget to download kegg items one-by-one (~2 weeks, if lucky)
```sh
mkdir kegg_db_p1
cd kegg_db_p1
perl /PATH/TO/kegg_db_wget_p1.pl
cd ..

mkdir kegg_db_p2
cd kegg_db_p2
sh /PATH/TO/kegg_db_wget_p2.sh
cd ..

mkdir kegg_db_p3
cd kegg_db_p3
sh /PATH/TO/kegg_db_wget_p3.sh /PATH/TO/YOUR/OSDB_dir
sh /PATH/TO/kegg_db_wget_p4.sh
```

Links to databse:
-----
cazy
http://www.cazy.org/
https://bcb.unl.edu/dbCAN2/download/

cog
https://ftp.ncbi.nih.gov/pub/COG/

tcdb
https://tcdb.org/download.php

merops
https://www.ebi.ac.uk/merops/download_list.shtml
Peptidase Full-length Sequences is chosen.

swissprot
https://www.ncbi.nlm.nih.gov/home/download/

pfam-A
https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/

UniProtKB-TrEMBL
https://www.uniprot.org/help/downloads

nr
https://www.ncbi.nlm.nih.gov/home/download/

kegg
https://www.kegg.jp/kegg/rest/keggapi.html

- `prepared local database release 20240311`: URL...
