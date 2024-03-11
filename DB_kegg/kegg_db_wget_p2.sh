#scripts updated on 2024/3/11
mkdir kegg_db_p2
cd kegg_db_p2
echo "getting ko to gene infomation ..."
mkdir ko_gene_info
cd ko_gene_info
wget -c http://rest.kegg.jp/list/ko --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/'
cut -f 1 ko | sed 's/ko://' | while read id; do wget -nc http://rest.kegg.jp/link/genes/$id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/'; done
cat K* | sed 's/ko://' > ko_genes.txt
mv ko ../ko_info.txt
cd ../
mv ko_gene_info/ko_genes.txt ./

echo "ko id in ko_info.txt :"
less ko_info.txt | wc -l
echo "downloaded ko txt in ko_gene_info :"
ls ko_gene_info/ | wc -l
echo "if numbers are not equal, pls rerun the script, the downloaded data will be kept"
