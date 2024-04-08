cd genome_split
for id in `ls`
do
  cd $id
  cut -f 2 $id |sort |uniq -c |sed 's/^\s*//' |sed 's/\s/\t/'|awk '{print $2"\t"$1}' > $id'_gene_type.txt'
  cd ..
done
