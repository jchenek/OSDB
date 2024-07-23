#!/bin/bash
#scripts updated on 2024/3/7
#usage: sh .sh 
echo "make sure ko_genes.txt can be found in current path"
echo "getting all gene seq ..."
mkdir gene_seq
cd gene_seq

cp ../ko_genes.txt ./
cut -f 2 ko_genes.txt | while read id; do wget -nc http://rest.kegg.jp/get/$id/aaseq -O ${id//:/_} --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1 Safari/605.1.15'; done
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

rm ko_genes.txt
cat * > ../kegg_genes.fasta
cd ../

echo "gene number in ko_genes.txt :"
less ko_genes.txt | wc -l
echo "downloaded gene in gene_seq :"
ls gene_seq/ | wc -l
echo "if numbers are not equal, pls rerun the script, the downloaded seq will be kept"