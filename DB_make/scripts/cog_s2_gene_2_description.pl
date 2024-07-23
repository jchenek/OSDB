#!usr/bin/perl
use warnings;
#usage: perl .pl raw_fa > id.txt

open IN, "$ARGV[0]";

while(<IN>){
	chomp;
	if(m/>/){
	s/>//;
	$ID = $_;
	$ID =~ s/ /\t/;
	print "$ID\n";
	}
}
