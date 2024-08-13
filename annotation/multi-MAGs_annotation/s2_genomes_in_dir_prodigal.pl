#!/usr/bin/perl -w
#usage: perl .pl <IN dir_name>

use warnings;
($dir) = @ARGV ;
$dir =~ s/\/$//;

open OU2, ">./prodigal_com";
print OU2 "mkdir -p prodigal/cds_faa\n";
print OU2 "mkdir -p prodigal/cds_fna\n";
print OU2 "mkdir -p prodigal/gff\n";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

$com_num = 0;
foreach my$file (@filelist) {
	chomp($file);
	if($file =~ m/fa/){
	$file =~ s/.fa//;
	print OU2 "prodigal -i $dir\/$file.fa -o prodigal/gff/$file.gff -f gff -p meta -a prodigal/cds_faa/$file.cds.faa -d prodigal/cds_fna/$file.cds.fna &\n";
	}
	if($file =~ m/fna/){
	$file =~ s/.fna//;
	print OU2 "prodigal -i $dir\/$file.fna -o prodigal/gff/$file.gff -f gff -p meta -a prodigal/cds_faa/$file.cds.faa -d prodigal/cds_fna/$file.cds.fna &\n";
	}
	$com_num = $com_num + 1;
	if($com_num > 70){
		print OU2 "wait\n";
		$com_num = 0;
	}
}
print OU2 "wait\n";
print OU2 "echo \"######all done######\"\n";
close OU2;
#print "sh prodigal_com\n";
system ("sh prodigal_com");


