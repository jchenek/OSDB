#!/usr/bin/perl -w
use warnings;
#Usage: perl .pl <IN original_file> > <OU file>

open II, "<$ARGV[0]";
while (<II>) {
	chomp;
	s/\r//g;
	s/"//g;
	s/,/\t/g;
	$id1=(split /\t/,$_)[2]; #<------target
	$id2=(split /\t/,$_)[6]; #<------target
	$id1=~s/\./_/g;
	print "$id1\t$id2\n";
	}
close II;
