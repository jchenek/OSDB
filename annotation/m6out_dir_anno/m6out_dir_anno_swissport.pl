#!/usr/bin/perl -w
#put all .m6out files in a dir
#mkdir dir called $out_dir_1
#usage: perl m6out_dir_anno.pl <IN swissprot_annotation.txt> <IN dir_name> <IN out_dir_name>
#$out_dir_1: annotation

use warnings;
($anno,$dir,$out_dir) = @ARGV ;
$out_dir =~ s/\///;

mkdir("$out_dir\_1");

#input full annotation file
open IN, "$anno";
	while (<IN>) {
		chomp;
		$ID_db = (split/\t/,$_)[0]; #<---gene id in db
		$des = (split/\t/,$_)[1]; #<---gene description in db
		$hash{$ID_db}="$des";
	}
close IN;

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /m6out/){

	open II, "$DIR_PATH/$file" || die "can not open";
	open OU, ">./$out_dir\_1/$file\.anno.tsv";
	while (<II>) {
		chomp;
		$ID1 = (split /\t/,$_)[0]; #<---id in MAGs
		$ID2 = (split /\t/,$_)[1]; #<---id in db
		if (exists $hash{$ID2}) {
			$ID3 = $hash{$ID2}; #<---gene description in db
			print OU "$ID1\t$ID2\t$ID3\n";

		}
	}

	close II;
	close OU;
}
}


