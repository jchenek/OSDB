#!usr/bin/perl
use warnings;
#usage: perl .pl raw_fa > id.txt

open IN, "$ARGV[0]";

while(<IN>){
	chomp;
	if(m/>/){
	s/>//;
	$ID = $_;
	$ID1_1 = (split/ /,$ID)[0];
	$ID1_2 = (split/ /,$ID)[1];
	$ID1_3 = (split/\|/,$ID)[1];
	print "$ID1_1\t$ID1_2\t$ID1_3\n";
	}
}
