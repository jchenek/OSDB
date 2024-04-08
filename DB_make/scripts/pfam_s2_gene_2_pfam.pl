#!usr/bin/perl
use warnings;
#usage: perl .pl raw_fa > id.txt

open IN, "$ARGV[0]";

while(<IN>){
	chomp;
	if(m/>/){
	s/>//;
	$ID = $_;
	$ID1_1 = (split/\//,$ID)[0];
	$ID =~ / (PF.*)/;
	$ID1_2 = $1;
	$ID1_3 = (split/\;/,$ID1_2)[0];
	print "$ID1_1\t$ID1_3\n";
	}
}
