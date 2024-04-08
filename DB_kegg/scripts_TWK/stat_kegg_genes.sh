cd genome_split
for id in `ls`
do
  cd $id
  echo $id `grep ">" $id'_protein.faa' |wc -l` `grep ">" $id'_protein.faa' |sed 's/\s/\t/'| sed -n '/\tK[0-9][0-9]*\s/p'|wc -l` `grep ">" $id'_protein.faa' |sed -n '/\sno\sKO\sassigned/p'|wc -l` >> ../../genome_gene_stat.txt
  cd ..
done
