#!/usr/bin/perl -w
#run this script in dir diamond_out
#usage: perl .pl <IN path_to_diamond_db> <path_to_dir_m6out_dir_anno>

use warnings;
($path, $dev) = @ARGV ;
open OU2, ">./anno_com";
print OU2 "echo \"annotating ...\"\n";

print OU2 "perl $dev\/m6out_dir_anno_cazy.pl $path\/cazy/cazy_2_category.txt cazy/ cazy/ & \n";
print OU2 "perl $dev\/m6out_dir_anno_cog.pl $path\/cog/cog_annotation.txt cog/ cog/ & \n";
print OU2 "perl $dev\/m6out_dir_anno_merops.pl $path\/merops/merops_2_category.txt merops/ merops/ & \n";
print OU2 "perl $dev\/m6out_dir_anno_swissport.pl $path\/swissprot/swissprot_annotation.txt swissprot/ swissprot/ & \n";
print OU2 "perl $dev\/m6out_dir_anno_tcdb.pl $path\/tcdb/gene_2_description_substance.txt tcdb/ tcdb/ & \n";
print OU2 "perl $dev\/m6out_dir_anno_kegg.pl $path\/kegg/kegg_annotation.txt kegg/ kegg/ & \n";
print OU2 "perl $dev\/m6out_dir_anno_trembl.pl $path\/UniProtKB-TrEMBL/trembl_annotation.txt UniProtKB-TrEMBL/ UniProtKB-TrEMBL/ & \n";

print OU2 "wait\n";
print OU2 "echo \"done\"\n";

close OU2;
system ("sh anno_com");


