#!/usr/bin/perl -w
#usage: perl .pl <IN cog-20.def.tab.txt> <IN gene_2_cog> > <OU anno.txt>

use warnings;
open IN, "<$ARGV[0]";
open II, "<$ARGV[1]";

	while (<IN>) {
		chomp;
		$ID1 = (split/\t/,$_)[0];
		$ID2 = (split/\t/,$_)[1];
		$ID3 = (split/\t/,$_)[2];
		$hash{$ID1}="$ID2\t$ID3";
	}

	while (<II>) {
		chomp;
		$ID1 = (split /\t/,$_)[0];
		$ID2 = (split /\t/,$_)[1];
		$ID3 = $hash{$ID2};
		print "$ID1\t$ID2\t$ID3\n";
	}

close IN;
close II;