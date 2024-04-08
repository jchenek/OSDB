cd genome_split
for id in `cat $1`
do
  cd $id/$id'_genes'
  for fa in `ls kegg_genes*.fasta`
  do
    echo -e "$fa\t`tail -n1 $fa |wc -l`" >> ../$id'_file_check.txt'
  done
  cd ../..
done
