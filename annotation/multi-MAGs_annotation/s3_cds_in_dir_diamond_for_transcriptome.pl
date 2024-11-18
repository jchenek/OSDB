#!/usr/bin/perl -w
#usage: perl .pl <IN faa_dir_name> <IN path_to_database>
#dir_name: all cds.fna or cds.faa are in one dir, prodigal output is ok, no need to reformate
#parameters: --sensitive -k 1 -e 1e-20 -c1 --query-cover 70 --subject-cover 70 --id 40
#https://github.com/bbuchfink/diamond/wiki/1.-Tutorial
#for transcriptome, we decrease the coverage

use warnings;
($dir, $path) = @ARGV ;
open OU2, ">./diamond_com";
print OU2 "mkdir diamond_out\n";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /faa/){
	$file_name = $file;
	$file_name =~ s/\.faa//;
	print OU2 "mkdir diamond_out/swissprot\n";
	print OU2"diamond blastp --db $path\/swissprot/*.dmnd --query $dir\/$file --out ./diamond_out/swissprot/$file_name.swissprot.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 40 --subject-cover 40 --id 40\n";
	print OU2 "mkdir diamond_out/cazy\n";
	print OU2 "diamond blastp --db $path\/cazy/*.dmnd --query $dir\/$file --out ./diamond_out/cazy/$file_name.cazy.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 40 --subject-cover 40 --id 40\n";
	print OU2 "mkdir diamond_out/cog\n";
	print OU2 "diamond blastp --db $path\/cog/*.dmnd --query $dir\/$file --out ./diamond_out/cog/$file_name.cog.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 40 --subject-cover 40 --id 40\n";
	print OU2 "mkdir diamond_out/merops\n";
	print OU2 "diamond blastp --db $path\/merops/*.dmnd --query $dir\/$file --out ./diamond_out/merops/$file_name.merops.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 40 --subject-cover 40 --id 40\n";
	print OU2 "mkdir diamond_out/tcdb\n";
	print OU2 "diamond blastp --db $path\/tcdb/*.dmnd --query $dir\/$file --out ./diamond_out/tcdb/$file_name.tcdb.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 30 --subject-cover 30 --id 30\n";
	print OU2 "mkdir diamond_out/UniProtKB-TrEMBL\n";
	print OU2 "diamond blastp --db $path\/UniProtKB-TrEMBL/*.dmnd --query $dir\/$file --out ./diamond_out/UniProtKB-TrEMBL/$file_name.UniProtKB-TrEMBL.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 40 --subject-cover 40 --id 40\n";
	print OU2 "mkdir diamond_out/kegg\n";
	print OU2 "diamond blastp --db $path\/kegg/*.dmnd --query $dir\/$file --out ./diamond_out/kegg/$file_name.kegg.m6out --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovhsp scovhsp --sensitive -k 1 -e 1e-20 -c1 --query-cover 40 --subject-cover 40 --id 40\n";
	}
	}

system ("sh diamond_com");
