#scripts updated on 2024/3/7
#this script depends on extract_valid_genome_from_txt.pl
#to run: sh kegg_db_wget_p3.1.sh <IN path/to/OSDB>
mkdir kegg_db_p3
cd kegg_db_p3
echo "getting organisms infomation ..."
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

rm genome_taxo.txt
wget -c http://rest.kegg.jp/list/organism -O genome_taxo.txt --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/'

echo "getting all genome infomation ..."
mkdir genome_info
cd genome_info
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

rm genome
wget -c http://rest.kegg.jp/list/genome --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/'
perl $1/DB_kegg/extract_valid_genome_from_txt.pl genome > genome_info_valid.txt

cut -f 2 genome_info_valid.txt | cut -f 1 -d ";" | while read id; do wget -nc http://rest.kegg.jp/list/$id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/'; done
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

mv genome_info_valid.txt ../
mv genome ../genome_info_raw.txt
cd ../

echo "genome id in genome_info_valid.txt :"
less genome_info_valid.txt | wc -l
echo "downloaded genome in genome_info :"
ls genome_info | wc -l
echo "if numbers are not equal, pls rerun the script, the downloaded data will be kept"

echo "catting genome ..."
rm ./all_genes.list
cat ./genome_info/* | cut -f 1 > all_genes.list
echo "all genes id are in all_genes.list"