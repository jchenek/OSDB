#!/usr/bin/perl -w
use warnings;
#Usage: perl .pl <IN file> > <OU filted_file>

open II, "<$ARGV[0]";
while (<II>) {
	chomp;
	if (m/\;/) { #<------adjust to get target
	print "$_\n";
	}
}
close II;