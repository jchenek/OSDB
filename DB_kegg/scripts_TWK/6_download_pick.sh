cd genome_split
for id in `cat $1`
do
  cd $id
  cd $id'_genes'
  sed -n '/\t0$/p' ../$id'_file_check.txt' |cut -f 1 |while read id; do rm $id; done
  cd ..
  sed -n '/\t0$/p' $id'_file_check.txt' |cut -f 1 |awk -F " " 'NR==FNR{a[$1]=1}NR>FNR{if (a[$4]) print $0}' - $id'_genes_wget.sh' > $id'_genes_wget5.sh'
  cd ..
done
