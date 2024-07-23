#!/bin/sh
#scripts updated on 2024/3/11
#usage: sh .sh <IN list_of_target_ko_id>
#e.g.
#K00001\nK00002\nK00003

mkdir ko_gene_info
cut -f 1 $1 | sed 's/ko://' | while read id; do wget -nc http://rest.kegg.jp/link/genes/$id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O ./ko_gene_info/$id.txt; done
find ./ko_gene_info/ -name "*" -type f -size 0c |xargs -n 1 rm -rf

echo "number of input ko id :"
less $1 | wc -l
echo "downloaded ko txt in ko_gene_info :"
ls ko_gene_info/ | wc -l
echo "if numbers are not equal, pls rerun the script, the downloaded data will be kept"

echo "catting gene info ..."
cat ./ko_gene_info/* | sed 's/ko://' > ko_genes.txt
echo "done"
