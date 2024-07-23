cd genome_split
for id in `ls`
do
  cd $id
  cat $id | cut -f 1 > $id'_genes.list'
  sh ../../split_kegg_genes.sh $id'_genes.list' $id'_genes_split.list'
  awk '{print "wget -c -O kegg_genes"NR".fasta http://rest.kegg.jp/get/"$1"/aaseq"}' $id'_genes_split.list' > $id'_genes_wget.sh'
  mkdir $id'_genes'
  cd ..
done
