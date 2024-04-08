#!usr/bin/perl
use warnings;
#usage: perl .pl raw_fa > id.txt

open IN, "$ARGV[0]";

while(<IN>){
	chomp;
	if(m/>/){
	s/>//;
	$ID = $_;
	$ID1 = (split/ - /,$_)[0];
	$ID =~ /\#(.*)\#/;
	$ID2 = $1;
	print "$ID1\t$ID2\n";
	}
}
