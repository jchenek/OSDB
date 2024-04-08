OSDB (one-step database)
=======

OSDB is a pipeline for local database configuration.

- `Note 1`: Please check links in dir `DB_links` before run this pipeline. Make sure all links are valid.
- `Note 2`: It is common to meet `403 forbidden` issues when you are running kegg-related scripts. Just terminate the current running scripts and re-run it again, and again, and again ... The scripts will not delete downloaded data. And finally you will successfully download them all :)
- `last update`: 2024/04/10

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
conda activate OSDB
sh /PATH/TO/one-step-DB-download-p1-general.sh /PATH/TO/YOUR/OSDB_dir
```

- `Step 2`: download nr database

Will use aria2 to download nr link (~24 h)

```sh
conda activate OSDB
sh /PATH/TO/one-step-DB-download-p2-nr.sh /PATH/TO/YOUR/OSDB_dir
```

- `Step 3`: download kegg database

Will use wget to download kegg items one-by-one (~4 weeks, if lucky)

To save time, only sequences with ko id will be downloaded.

```sh
conda activate OSDB

#data from this part is for enrichment analysis
sh /PATH/TO/DB_kegg/kegg_db_wget_p1_data_for_enricher.sh /PATH/TO/YOUR/OSDB_dir

#ko seqs will be download in this part
sh /PATH/TO/DB_kegg/kegg_db_wget_p2_for_ko_genes.sh
perl /PATH/TO/DB_kegg/kegg_db_wget_p2_1_for_ko_genes_download_seq.pl ko_genes.txt

#(opt) all seqs will be download in this part
sh /PATH/TO/DB_kegg/kegg_db_wget_p3_opt_for_all_genes.sh /PATH/TO/YOUR/OSDB_dir
perl /PATH/TO/DB_kegg/kegg_db_wget_p3_1_opt_for_all_genes_download_seq.pl all_genes.list
```

- `Step 3`: make database

Check scripts in dir 'DB_make'


Links to databse:
-----
cazy: 
https://bcb.unl.edu/dbCAN2/download/

cog: 
https://ftp.ncbi.nih.gov/pub/COG/

tcdb: 
https://tcdb.org/download.php

merops (Peptidase Full-length): 
https://www.ebi.ac.uk/merops/download_list.shtml

swissprot: 
https://www.ncbi.nlm.nih.gov/home/download/

pfam-A: 
https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/

UniProtKB-TrEMBL: 
https://www.uniprot.org/help/downloads

nr: 
https://www.ncbi.nlm.nih.gov/home/download/

kegg: 
https://www.kegg.jp/kegg/rest/keggapi.html

- `prepared local database release 20240311`: URL...
