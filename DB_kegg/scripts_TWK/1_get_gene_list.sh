cd genome_split
for id in `ls`
do
  cd $id
  wget -c --no-check-certificate http://rest.kegg.jp/list/$id
  cd ..
done
