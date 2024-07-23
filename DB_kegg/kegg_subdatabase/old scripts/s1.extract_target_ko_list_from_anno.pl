#!/usr/bin/perl -w
use warnings;
#Usage: perl .pl <IN ko_id_list> <IN full_anno> > <OU annotation.txt>
#needs to be in lf format

%hash=();
open II, "<$ARGV[0]";
while (<II>) {
	chomp;
	$target_ko=(split /\t/,$_)[0]; #<------target ko id
	$hash{$target_ko}= 1;
}
close II;

open IN, "<$ARGV[1]";
while (<IN>) {
	chomp;
	$ko_id=(split /\t/,$_)[1]; #<------read ko id from annotation
	#$id=~s/\>//;
	if ($hash{$ko_id}) {
	print "$_\n";
	}
}
close IN;
