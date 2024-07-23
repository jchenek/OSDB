#!/usr/bin/perl -w
use warnings;
#Usage: perl .pl <IN annotation.txt> <IN original_faa_db> > <OU sub_seq.faa>
#if some fa ID have the same name and matched, all will be extracted

%hash=();
open II, "<$ARGV[0]";
while (<II>) {
	chomp;
	s/\r//;
	$id2=(split /\s+/,$_)[0]; #<------target contig id
	$hash{$id2}= 1;
	}
close II;
open IN, "<$ARGV[1]";
$/=">";<IN>;
while (<IN>) {
	chomp;
	s/\r//;
	$id=(split /\s+/,$_)[0]; #<------read contig id from faa
	$seq=(split /\s+/,$_)[1]; #<------adjust to get seq
	#$id=~s/\>//;
	if ($hash{$id}) {
	print ">$id\n$seq\n";
	}
}
close IN;
