#!usr/bin/perl
#usage: perl kegg_pku_wget.pl
#scripts updated on 2021/8/15
#run this scripts only after 'keggmapper_db_wget.pl' finished
#run < wget --retry-connrefused -c ftp://ftp.cbi.pku.edu.cn/pub/KOBAS_3.0_DOWNLOAD/seq_pep/* > to download fasta from ftp set by pku (~20G)
#this script is used for preparing annotation file

use warnings;
use strict;

mkdir("ko_gene_pku_temp");
#extract genes from ko_ID_info
print "extracting genes from ko_ID_info ...\n";
my$DIR_PATH = "./ko_ID_info";
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
foreach my$file (@filelist) {
	if($file =~ m/.txt/){
		my$ID = $`;
		my$key = 0;
		open OU3, ">./ko_gene_pku_temp/$ID\_gene_pku.txt";
		open IN1, "$DIR_PATH/$file" || die "can not open";
		while(<IN1>){
			chomp;
			if(m/^GENES/){
				$key = 1;
				s/GENES       /            /;
			}
			if($key == 1){
				if (m/            / == 0){
					$key = 0;
					last;
				}
				my$gene_ID = $_;
				$gene_ID =~ s/            \w+: //;
				$gene_ID =~ s/ /\n/g;
				print OU3 "$gene_ID\n";
			}
		}
	}
close OU3;
close IN1;
}

#summaring ko_gene_pku_temp to get annotation file
print "summaring ko_gene_pku_temp ...\n";
$DIR_PATH = "./ko_gene_pku_temp";
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
@filelist = readdir DIR;
open OU3, ">./kegg_pku_annotation.temp";
foreach my$file (@filelist) {
	if($file =~ m/_gene_pku.txt/){
		my$ID = $`;
		open IN1, "$DIR_PATH/$file" || die "can not open";
		while(<IN1>){
			chomp;
				my$gene_ID = $_;
				$gene_ID =~ s/\(\S+\)//;
				print OU3 "$gene_ID\t$ID\n";
			}
		}
	}
close OU3;
close IN1;
print "preparing annotation file ...\n";
open IN, "./ko_list_wb.txt" or die "can not open ko_list_wb.txt\n";
my %hash;
	while (<IN>) {
		chomp;
		s/^ko://;
		my$ID_db = (split/\t/,$_)[0];
		my$ID_db2 = (split/\t/,$_)[1];
		$hash{$ID_db} = "$ID_db2";
	}
	close IN;
	open II, "./kegg_pku_annotation.temp" or die "can not open kegg_pku_annotation.temp\n";
	open OU4, ">./kegg_pku_annotation.txt";
	while (<II>) {
		chomp;
		my$ID_db = (split/\t/,$_)[0];
		my$ID_db2 = (split/\t/,$_)[1];
		print OU4 "$ID_db\t$ID_db2\t$hash{$ID_db2}\n";

	}

print "successfully output kegg_pku_annotation.txt\n";
print "you can delete dir ko_gene_pku_temp using 'rm -r ko_gene_pku_temp'\n";
print "you can delete file kegg_pku_annotation.temp using 'rm kegg_pku_annotation.temp'\n";