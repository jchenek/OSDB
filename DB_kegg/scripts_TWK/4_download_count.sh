cd genome_split
for id in `ls`
do
  cd $id/$id'_genes'
  echo -e "$id\t`ls |wc -l`" >> ../../../download_count.txt
  cd ../..
done
