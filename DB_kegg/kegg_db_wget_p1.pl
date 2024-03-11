#!usr/bin/perl
#usage: perl keggmapper_db_wget.pl
#scripts updated on 2024/3/11
#this script will get all information EXCEPT seq data from kegg; to get faa seq data, please run 'kegg_pku_wget.pl'

use warnings;
use strict;
use LWP::Simple;

#get the list of ko_ID, pathway_ID, module_ID and their simple description
open OU1_1, ">ko_list_wb.txt";
my $ko_list_wb = get("http://rest.kegg.jp/list/ko");
print OU1_1 $ko_list_wb;
print "get ko_list_wb.txt\n";
close OU1_1;
open OU1_2, ">pathway_list_wb.txt";
my $pathway_list_wb = get("http://rest.kegg.jp/list/pathway");
print OU1_2 $pathway_list_wb;
print "get pathway_list_wb.txt\n";
close OU1_2;
open OU1_3, ">module_list_wb.txt";
my $module_list_wb = get("http://rest.kegg.jp/list/module");
print OU1_3 $module_list_wb;
close OU1_3;
print "get module_list_wb.txt\n";

#get full information of each ko_ID, these .txt files are put in dir 'ko_ID_info'
mkdir("ko_ID_info");
print "getting full information of each ko_ID ... (needs ~2 hours)\n";
open IN, "./ko_list_wb.txt" or die "cannot open file ko_list_wb.txt";
while(<IN>){
	chomp;
	s/^ko\://;
	my$ko_ID = (split /\t/,$_)[0];
	system("wget -nc http://rest.kegg.jp/get/$ko_ID --referer=\'http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/\' -O ko_ID_info/$ko_ID.txt");
}
close IN;

#get a file prekegg2gene_pathway.csv and prekegg2gene_module.csv as the input of the enricher
print "summarizing prekegg2gene_pathway.csv and prekegg2gene_module.csv ...\n";
my$DIR_PATH = "./ko_ID_info";
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
open OU3, ">prekegg2gene_pathway.csv";
open OU4, ">prekegg2gene_module.csv";
foreach my$file (@filelist) {
	if($file =~ m/.txt/){
		my$ID = $`;
		open IN1, "$DIR_PATH/$file" || die "can not open";
		while(<IN1>){
			chomp;
			if(m/^BRITE/){
				last;
			}
			if(m/map[0-9][0-9][0-9][0-9][0-9]  [A-Z]/){
				my$pathway_ID = $&;
#				$pathway_ID =~ s/ko/map/;
				$pathway_ID =~ s/  [A-Z]//;
				print OU3 "$pathway_ID,$ID\n";
			}
			if(m/M[0-9][0-9][0-9][0-9][0-9]  [A-Z]/){
				my$module_ID = $&;
				$module_ID =~ s/  [A-Z]//;
				print OU4 "$module_ID,$ID\n";
			}
		}
	}
}
close OU3;
close OU4;
close IN1;
print "kegg_db_p1 finished\n";

print "ko id in ko_list_wb.txt: \n";
system("less ko_list_wb.txt \| wc -l");
print "downloaded ko txt in ko_ID_info :\n";
system("ls ko_gene_info/ \| wc -l");
print "if the two numbers are not equal, pls rerun the script again tomorrow, the downloaded data will be kept\n";