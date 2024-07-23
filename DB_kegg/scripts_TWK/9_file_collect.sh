cd genome_split
for id in `cat $1`
do
  cd $id/$id'_genes'
  cat kegg_genes*.fasta > ../$id'_protein.faa'
  cd ..
  tar -zcv -f $id'_protein.tar.gz' $id'_genes'
  cd ..
done
