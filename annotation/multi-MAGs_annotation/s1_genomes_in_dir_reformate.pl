#!/usr/bin/perl -w
#put all fa files in a dir
#usage: perl .pl <IN path_to_DEV_fa_reformat_v2.pl> <IN dir_name>

use warnings;
($dev_pl, $dir) = @ARGV ;
$dir =~ s/\///;

mkdir("$dir\_reformated");
open OU2, ">./reformate_com";

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /fna/){
	print OU2 "perl $dev_pl $dir\/$file > $dir\_reformated/$file\n"; 
}
	if($file =~ /fa/){
	print OU2 "perl $dev_pl $dir\/$file > $dir\_reformated/$file\n"; 
}
}
close OU2;
#print "sh reformate_com\n";
system ("sh reformate_com");


