cd genome_split
for id in `cat $1`
do
  cd $id
  rm -r $id'_genes'
  cd ..
done
