#!/usr/bin/perl -w
#usage: perl .pl <IN dir_name>

use warnings;
use strict; 

my ($dir) = @ARGV;
die "Usage: $0 <IN dir_name>\n" unless $dir;
$dir =~ s/\/$//;

# 1. Create target output directories
system("mkdir -p prodigal/cds_faa");
system("mkdir -p prodigal/cds_fna");
system("mkdir -p prodigal/gff");

# 2. Open command list file
open OU2, ">./prodigal_com" or die "Cannot write to ./prodigal_com: $!\n";

my $DIR_PATH = $dir;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my @filelist = readdir DIR;
closedir DIR;

# 3. Iterate through files and generate command lines
foreach my $file (@filelist) {
    chomp($file);
    next if $file =~ /^\./; 

    if ($file =~ m/\.fa(sta)?$|\.fna$/i) {
        my $prefix = $file;
        $prefix =~ s/\.fa(sta)?$|\.fna$//i;
        print OU2 "prodigal -i $dir/$file -o prodigal/gff/$prefix.gff -f gff -p meta -a prodigal/cds_faa/$prefix.cds.faa -d prodigal/cds_fna/$prefix.cds.fna\n";
    }
}
close OU2;

# 4. Launch parallel tasks using xargs
print "Starting prodigal tasks with optimized pipeline concurrency...\n";
system("cat ./prodigal_com | xargs -P 70 -I {} sh -c \"{}\"");

print "######all done######\n";
