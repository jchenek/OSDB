#!usr/bin/perl
use warnings;
#usage: perl .pl <IN getSubstrates.py> <IN tcdb> > <OU anno.txt>

open IN, "$ARGV[0]";
	while (<IN>) {
		chomp;
		$ID1 = (split/\t/,$_)[0];
		$ID2 = (split/\t/,$_)[1];
		$hash{$ID1}="$ID2";
	}
close IN;

open IN, "<$ARGV[1]";
while(<IN>){
	chomp;
	if(m/>/){
	if(m/UPI0002B5B01D/){next;} #<-----------------------the only error seq
	s/>//;
	s/ \|/\|/;
	$ID = $_;
	$ID1_1 = (split/ /,$ID)[0];
	$ID1_1_1 = (split/\|/,$ID1_1)[2];
	$ID1_1_2 = (split/\|/,$ID1_1)[3];
	$ID =~ s/ /\t/;
	$ID_2 = (split/\t/,$ID)[1];
	if(exists($hash{$ID1_1_2})){
		$ID_3 = $hash{$ID1_1_2}
	}else{
		$ID_3 = "null";
	}

	print "$ID1_1_1\t$ID1_1_2\t$ID_3\t$ID_2\n";
	}
}
close IN;
