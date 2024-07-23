cd genome_split
for id in `cat $1`
do
  cd $id
  echo $id `cat $id'_genes_wget1.sh' |wc -l` `cat $id'_genes_wget2.sh' |wc -l` `cat $id'_genes_wget3.sh' |wc -l` `cat $id'_genes_wget4.sh' |wc -l` `cat $id'_genes_wget5.sh' |wc -l` >> ../../tt.txt
  cd ..
done
