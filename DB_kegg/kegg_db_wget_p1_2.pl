#!usr/bin/perl
#usage: perl .pl
#scripts updated on 2024/3/11

#get a file prekegg2gene_pathway.csv and prekegg2gene_module.csv as the input of the enricher
print "summarizing prekegg2gene_pathway.csv and prekegg2gene_module.csv ...\n";
my$DIR_PATH = "./ko_ID_info";
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
open OU3, ">prekegg2gene_pathway.csv";
open OU4, ">prekegg2gene_module.csv";
foreach my$file (@filelist) {
	if($file =~ m/.txt/){
		my$ID = $`;
		open IN1, "$DIR_PATH/$file" || die "can not open";
		while(<IN1>){
			chomp;
			if(m/^BRITE/){
				last;
			}
			if(m/map[0-9][0-9][0-9][0-9][0-9]  [A-Z]/){
				my$pathway_ID = $&;
#				$pathway_ID =~ s/ko/map/;
				$pathway_ID =~ s/  [A-Z]//;
				print OU3 "$pathway_ID,$ID\n";
			}
			if(m/M[0-9][0-9][0-9][0-9][0-9]  [A-Z]/){
				my$module_ID = $&;
				$module_ID =~ s/  [A-Z]//;
				print OU4 "$module_ID,$ID\n";
			}
		}
	}
}
close OU3;
close OU4;
close IN1;