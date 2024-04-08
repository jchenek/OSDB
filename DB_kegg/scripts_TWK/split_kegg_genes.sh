awk '
{
if (NR % 9 == 1) {a=$1} 
else if (NR % 9 == 2) { a=a"+"$1}
else if (NR % 9 == 3) { a=a"+"$1}
else if (NR % 9 == 4) { a=a"+"$1}
else if (NR % 9 == 5) { a=a"+"$1}
else if (NR % 9 == 6) { a=a"+"$1}
else if (NR % 9 == 7) { a=a"+"$1}
else if (NR % 9 == 8) { a=a"+"$1}
else if (NR==FNR) {a=a"+"$1; print a}
else {a=a"+"$1; print a}
}' $1 > split_gene_list.temp1
final=`cat $1 | wc -l`
echo $final
declare -i rest=$final%9
tail -n $rest $1 | awk 'NR==1{a=$1}NR>1{a=(a"+"$1)}END{print a}' > split_gene_list.temp2
cat split_gene_list.temp1 split_gene_list.temp2 > $2
rm split_gene_list.temp1 split_gene_list.temp2
