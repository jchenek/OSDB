#!/usr/bin/perl -w
#usage: perl get_shared_id_data_from_dir.pl <IN dir_name> > <OU out_file_name>
#input anno_1 dir
use warnings;
($dir) = @ARGV ;

my$DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
my%hash = ();

foreach my$file (@filelist) {
if($file =~ m/tsv/){
	open II, "$DIR_PATH/$file" || die "can not open";
	while (<II>) {
		chomp;
		my$id=(split /\s+/,$_)[0]; #<------target id
		$hash{$id}= $_;
	}
	close II;
	}
}

foreach $_(keys %hash)
{
	print "$_\t";
	print "$hash{$_}\n";
}




