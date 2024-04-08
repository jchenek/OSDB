cd genome_split
for id in `cat $1`
do
  cd $id/$id'_genes'
  sh ../$id'_genes_wget4.sh'
  cd ../..
done
