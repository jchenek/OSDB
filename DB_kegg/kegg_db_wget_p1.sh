#scripts updated on 2024/3/11
mkdir kegg_db_p1
cd kegg_db_p1

wget -nc http://rest.kegg.jp/list/ko --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O ko_list_wb.txt
wget -nc http://rest.kegg.jp/list/pathway --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O pathway_list_wb.txt
wget -nc http://rest.kegg.jp/list/module --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O module_list_wb.txt

mkdir ko_ID_info
cut -f 1 ko_list_wb.txt | sed 's/ko://' | while read id; do wget -nc http://rest.kegg.jp/get/$id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O ko_ID_info/$id.txt; done

perl $1/DB_kegg/kegg_db_wget_p1_2.pl

echo "ko id in ko_list_wb.txt:";
less ko_list_wb.txt | wc -l
echo "downloaded ko txt in ko_ID_info:";
ls ko_gene_info/ | wc -l
echo "if the two numbers are not equal, pls rerun the script again tomorrow, the downloaded data will be kept";