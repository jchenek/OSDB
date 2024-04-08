#!usr/bin/perl
#usage: perl keggmapper_db_wget.pl
#scripts updated on 2021/8/13
#after finished this script, run commond '' 
!!!!!这个scripts是一个没有完成的scripts，因为多次从kegg api下载的操作会被kegg拒绝访问，不要使用这个脚本来获取kegg seq数据
下载kegg数据，请参考另一个脚本'kegg_pku_wget.pl'

use warnings;
use strict;
use LWP::Simple;

open OU1_4, ">genome_list_wb.txt";
my$genome_list_wb = get("http://rest.kegg.jp/list/genome");
print OU1_4 $genome_list_wb;
close OU1_4;
print "get genome_list_wb.txt\n";

#get all gene_ID; output a txt file 'gene_list_wb.txt' and a dir 'genome_gene_info', these two things shared same information.
mkdir("genome_gene_info");
print "getting genome_gene_info ...\n";
open IN, "./genome_list_wb.txt" or die "cannot open file ko_list_wb.txt";
while(<IN>){
	chomp;
	s/\t/,/;
	my$gene_ID = (split /,/,$_)[1];
	my$gene_list = get("http://rest.kegg.jp/list/$gene_ID");
	while(defined($gene_list) == 0){#check point, kegg api revokes long-time user temporarily
		my$gene_list = get("http://rest.kegg.jp/list/$gene_ID");
	}
	open OU1_4, ">genome_gene_info/$gene_ID.txt";
	open OU1_6, ">>","./gene_list_wb.txt";
	print OU1_4 $gene_list;
	print OU1_6 $gene_list;
	close OU1_4;
	close OU1_6;
}
close IN;

#get all gene_ID; output a txt file 'gene_list_wb.txt' and a dir 'genome_gene_info', these two things shared same information.
mkdir("full_gene_info");
print "getting full_gene_info ...\n";
open IN, "./gene_list_wb.txt" or die "cannot open file ko_list_wb.txt";
while(<IN>){
	chomp;
	my$gene_ID = (split /\t/,$_)[0];
	my$gene_info = get("http://rest.kegg.jp/get/$gene_ID");
	while(defined($gene_info) == 0){#check point, kegg api revokes long-time user temporarily
		my$gene_info = get("http://rest.kegg.jp/get/$gene_ID");
	}
	open OU1_4, ">full_gene_info/$gene_ID.txt";
	open OU1_6, ">>","./gene_list_wb.txt";
	print OU1_4 $gene_info;
	print OU1_6 $gene_info;
	close OU1_4;
	close OU1_6;
}
close IN;

#Following scripts are not efficient for seq downloading
#get faa sequences of each ko_gene and output a fasta file called 'kegg_database.faa', this faa file can be used for annotation.
#print "getting faa kegg_database for annotation ...\n";
#mkdir("ko_gene_seq");
#my$DIR_PATH = "./ko_gene_info"; #set the ko_gene_info path here
#opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
#my@filelist = readdir DIR;

#foreach my$file (@filelist) {
#if($file =~ m/.txt/){
#open IN, "./ko_gene_info/$file" or die "cannot open file ko_gene.txt";
#while(<IN>){
#	chomp;
#	$file =~s/.txt//;
#	my$gene_ID = (split /\t/,$_)[1];
#	my$gene_faa = get("http://rest.kegg.jp/get/$gene_ID/aaseq");
#	while(defined($gene_faa) == 0){#check point, kegg api revokes long-time user temporarily
#		$gene_faa = get("http://rest.kegg.jp/get/$gene_ID/aaseq");
#	}
#	open OU1_5, ">>","./ko_gene_seq/$file.faa";
#	print OU1_5 $gene_faa;
#	close OU1_5;
#}
#}
#}
#print "get kegg_database.faa\n";
#get faa sequences of each ko_gene and output a fasta file called 'kegg_database.faa', this faa file can be used for annotation.