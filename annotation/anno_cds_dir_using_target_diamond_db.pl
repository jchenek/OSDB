#!/usr/bin/perl -w
#usage: perl .pl <IN dir_name> <IN path_to_database_dmnd>
#this script needs OSDB env in whick diamond is available
#dir_name: all cds.fna or cds.faa are in one dir, prodigal output is ok, no need to reformate
#for .faa blastp will be used; for .fna blastx will be used
#parameters: --sensitive -k 1 -e 1e-20 -c1 --query-cover 70 --subject-cover 70 --id 40
#https://github.com/bbuchfink/diamond/wiki/1.-Tutorial

use warnings;
($dir, $db) = @ARGV ;
open OU2, ">./diamond_com";
print OU2 "#!/bin/bash\n";
print OU2 "source ~/miniconda3/etc/profile.d/conda.sh\n";
print OU2 "conda activate OSDB\n";
print OU2 "mkdir diamond_out\n";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /faa/){
	$file_name = $file;
	$file_name =~ s/\.faa//;
	print OU2"diamond blastp --db $db --query $dir\/$file --out ./diamond_out/$file_name.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 70 --subject-cover 70 --id 40\n";
	}
	if($file =~ /fna/){
	$file_name = $file;
	$file_name =~ s/\.fna//;
	print OU2"diamond blastx --db $db --query $dir\/$file --out ./diamond_out/$file_name.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 70 --subject-cover 70 --id 40\n";
	}
}
system ("bash diamond_com");
