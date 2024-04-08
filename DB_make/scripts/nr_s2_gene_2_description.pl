#!usr/bin/perl
use warnings;
#usage: perl .pl raw_fa > id.txt

open IN, "$ARGV[0]";

while(<IN>){
	chomp;
	if(m/>/){
	s/>//;
	$ID = $_;
	$ID1_1 = (split/\01/,$ID)[0];
	$ID1_1 =~ s/ /\t/;
	$ID1_1 =~ s/\[/\t/;
	$ID1_1 =~ s/\]//;
	print "$ID1_1\n";
	}
}
