#scripts updated on 2024/3/11
#usage: perl /PATH/TO/DB_kegg/kegg_db_wget_p1.pl /PATH/TO/YOUR/OSDB_dir
mkdir kegg_db_p1
cd kegg_db_p1

find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf
rm ko_list_wb.txt
wget -c http://rest.kegg.jp/list/ko --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O ko_list_wb.txt
rm pathway_list_wb.txt
wget -c http://rest.kegg.jp/list/pathway --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O pathway_list_wb.txt
rm module_list_wb.txt
wget -c http://rest.kegg.jp/list/module --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O module_list_wb.txt

mkdir ko_ID_info
find ./ko_ID_info -name "*" -type f -size 0c |xargs -n 1 rm -rf
cut -f 1 ko_list_wb.txt | sed 's/ko://' | while read id; do wget -nc http://rest.kegg.jp/get/$id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -O ko_ID_info/$id.txt; done
find ./ko_ID_info -name "*" -type f -size 0c |xargs -n 1 rm -rf

perl $1/DB_kegg/kegg_db_wget_p1_2.pl

echo "ko id in ko_list_wb.txt:"
less ko_list_wb.txt | wc -l
echo "downloaded ko txt in ko_ID_info:"
ls ko_ID_info/ | wc -l
echo "if the two numbers are not equal, pls rerun the script again tomorrow, the downloaded data will be kept"
