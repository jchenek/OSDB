#!/usr/bin/perl -w
use warnings;

#usage: perl get_shared_data_from_files.pl shared_id.txt dir_name > shared_data.xls
#input file should only contain lf not crlf
($shared_id,$dir_name) = @ARGV ;


my$DIR_PATH = "./$dir_name"; #set the dir path here


opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
my@table = ();
my$i = 0;

open IN, "$shared_id" or die;
while(<IN>){
	chomp;
	$table[$i] = (split /\s+/,$_)[0];
	$i++;
}
print "ID";

foreach my$file (@filelist) {
if($file =~ m/tsv/){
	my%hash = ();
	open II, "$DIR_PATH/$file" || die "can not open";
	$file =~ m/.m6out.uniid_num.tsv/; #<------remove wordy
	print "\t$`";
	while (<II>) {
		chomp;
		my$id=(split /\s+/,$_)[0]; #<------target 
		my$data=(split /\s+/,$_)[1]; #<------target 
		$hash{$id}=$data;
	}
	close II;
	foreach(@table){
		chomp;
		my$id2=(split /\s+/,$_)[0];
		if(exists($hash{$id2})){
			$_ = "$_\t$hash{$id2}";
		}else{
			$_ = "$_\t0";
		}
	}
	}
}
print "\n";
foreach (@table)
{
	chomp;
	s/\n/\t/;
	print "$_\n";
}




