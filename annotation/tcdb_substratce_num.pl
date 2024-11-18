#!/usr/bin/perl -w
use warnings;

#usage: perl get_shared_data_from_files.pl substratce_list.txt tcdb_1 > substratce_num.tsv
#input file should only contain lf not crlf
($shared_id,$dir_name) = @ARGV ;


my$DIR_PATH = "./$dir_name"; #set the dir path here

opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
my@table = ();
my$i = 0;

print "Genome_ID";
open IN, "$shared_id" or die;
while(<IN>){
	chomp;
	print "\t$_";
	$table[$i] = (split /\s+/,$_)[0];
	$i++;
}
print "\n";


foreach my$file (@filelist) {
if($file =~ m/tsv/){
	my%hash = ();
	foreach(@table){
		chomp;
		$hash{$_}= 0;
	}


	open II, "$DIR_PATH/$file" || die "can not open";
	$file =~ m/.tsv/; #<------remove wordy
	print "$`";
	while (<II>) {
		chomp;
		my$id=(split /\s+/,$_)[2]; #<------target
		foreach(@table){
		chomp;
		$subs = $_;
		if($id =~ m/$subs/){$hash{$subs}= $hash{$subs} + 1;}
	}
	}
	close II;


	foreach(@table){
		chomp;
		print "\t$hash{$_}";
	}
	print "\n";
	}
}




