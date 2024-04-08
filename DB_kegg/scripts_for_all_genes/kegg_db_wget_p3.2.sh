#scripts updated on 2024/3/7
echo "make sure all_genes.list can be found in current path"
echo "getting all gene seq ..."
mkdir gene_seq
cd gene_seq
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

cp ../all_genes.list ./
cat all_genes.list | while read id; do wget -nc http://rest.kegg.jp/get/$id/aaseq -O sed 's/://g' $id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1 Safari/605.1.15'; done
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

rm all_genes.list
cat * > ../kegg_genes.fasta
cd ../

echo "gene number in all_genes.list :"
less all_genes.list | wc -l
echo "downloaded gene in gene_seq :"
ls gene_seq/ | wc -l
echo "if numbers are not equal, pls rerun the script, the downloaded seq will be kept"