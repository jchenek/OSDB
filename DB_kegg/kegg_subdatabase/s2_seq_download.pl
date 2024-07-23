#!usr/bin/perl
#usage: perl .pl
#scripts updated on 2024/3/14
#perl .pl <IN ko_genes.txt>

open IN, "$ARGV[0]";

#get combined gene list
open OU, ">./combined_gene_list.txt";
$i = 0;
while(<IN>){
	chomp;
	$gene_id = (split /\t/,$_)[1];
	print OU "$gene_id";
	if($i < 9){
		print OU "+";
		$i = $i + 1;
	}else{
		print OU "\n";
		$i = 0;
	}
}
close OU;

#wget seqs
system("mkdir gene_seqs");
system("find ./gene_seqs -name "*" -type f -size 0c |xargs -n 1 rm -rf");
open IN, "./combined_gene_list.txt";
while(<IN>){
	chomp;
	$com_id = $_;
	$ou_id = $com_id;
	$ou_id =~ s/[\:+]/_/g;
#	print "$com_id\t$ou_id\n";
	system("wget -nc http://rest.kegg.jp/get/$com_id/aaseq -O ./gene_seqs/$ou_id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1 Safari/605.1.15'");
}
system("find ./gene_seqs -name "*" -type f -size 0c |xargs -n 1 rm -rf");

print "items in combined_gene_list.txt: \n";
system("less combined_gene_list.txt | wc -l");
print "downloaded items in gene_seqs: \n";
system("ls gene_seqs/ | wc -l");
print "if downloaded item number are LOWER than items in combined_gene_list.txt, pls rerun the script, the downloaded data will be kept\n";

print "catting genome ...\n";
system("cat ./gene_seqs/* | cut -f 1 > gene_seqs.fa");
print "done\n";