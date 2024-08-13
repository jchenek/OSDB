#!/usr/bin/perl -w
#put all .m6out files in a dir
#mkdir two dir called $out_dir_1, $out_dir_2, $out_dir_3
#usage: perl m6out_dir_anno.pl <IN cog_annotation.txt> <IN dir_name> <IN out_dir_name>
#$out_dir_1: annotation
#$out_dir_2 * _3: id and copy number

use warnings;
($anno,$dir,$out_dir) = @ARGV ;
$out_dir =~ s/\///;

mkdir("$out_dir\_1");
mkdir("$out_dir\_2");
mkdir("$out_dir\_3");

#input full annotation file
open IN, "$anno";
	while (<IN>) {
		chomp;
		$ID_db = (split/\t/,$_)[0]; #<---gene id in db
		$hash{$ID_db}="$_";
	}
close IN;

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;

foreach my$file (@filelist) {
	if($file =~ /m6out/){
	@table1 = ();
	@table2 = ();
	%hash1 = ();
	%hash2 = ();
	$i = 0;
	$j = 0;
	open II, "$DIR_PATH/$file" || die "can not open";
	open OU, ">./$out_dir\_1/$file\.anno.tsv";
	open OU2, ">./$out_dir\_2/$file\.uniid_num.tsv";
	open OU3, ">./$out_dir\_3/$file\.uniid_num.tsv";
	while (<II>) {
		chomp;
		$ID1 = (split /\t/,$_)[0]; #<---id in MAGs
		$ID2 = (split /\t/,$_)[1]; #<---id in db
		if (exists $hash{$ID2}) {
			$ID3 = (split /\t/,$hash{$ID2})[1]; #<---orthologous id
			$ID4 = (split /\t/,$hash{$ID2})[2]; #<---functional categories id
			$ID5 = (split /\t/,$hash{$ID2})[3]; #<---gene description
			print OU "$ID1\t$ID2\t$ID3\t$ID4\t$ID5\n";
			
			$table1[$i] = $ID3; #<---orthologous target
			$hash1{$ID3} = 0;
			$i++;
			$table2[$j] = $ID4; #<---functional categories target
			$hash2{$ID4} = 0;
			$j++;
		}
	}

foreach(@table1){
	chomp;
	if(exists($hash1{$_})){
		$hash1{$_}++;
	}
}
foreach $_(keys %hash1)
{
	print OU2 "$_\t$hash1{$_}\n";
}

foreach(@table2){
	chomp;
	if(exists($hash2{$_})){
		$hash2{$_}++;
	}
}
foreach $_(keys %hash2)
{
	print OU3 "$_\t$hash2{$_}\n";
}

	close II;
	close OU;
	close OU2;
	close OU3;
}
}


