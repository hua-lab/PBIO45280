
#! /usr/bin/perl
use warnings;
use strict;

open FILE,"<../proteome_databases/at_pep.fa";
my @file=<FILE>;
close FILE;

# Like in blast_parse.pl, we use open to read in the content of a file. However, here we do not use while loop to read each line.  We use an array to read in the entire file, including “\n” hidden return symbols.  Each line is a string of the array. 

my $file=join ('',@file);

# join is a Perl syntax which has an opposite function to split.  Here, it adds all strings in the @file array into a long string.

my @fasta_seqs=split /\>/,$file;

# Each fasta sequence starts with a “>” symbol.  Thus, each string in the new array @fasta_seqs starts with the identification line followed by sequence lines but without the “>” symbol. .

foreach my $fasta_seq(@fasta_seqs){

# Again, foreach is a syntax to read each string of an array one by one 

	my @lines=split /\n/,$fasta_seq;
	my $head_line=shift @lines;

# Here is a tricky part that is always used in programming.  In order to retrieve a specific fragment of a string, you need to look for the pattern.  You may use a regression expression or like the one here to retrieve the fragment.  Here, we know each fasta sequence contains at least two lines, the first is the identification line, and the remaining is the sequence.  We use a shift function to retrieve the first string in the array.  shift always takes away the first string of an array.

	print ">",$head_line,"\n";

# We know the first line is the identification of a sequence and we know a fasta sequence format begins with “>” symbol.

	my $seq=join ('',@lines);

# In some fasta files, its sequence lines may have already been formatted.  However, in order to make your own format, we need to remove the original format by joining all sequence lines into one line.

	foreach my $reformat_line (unpack("(A30)*",$seq) ){
		print $reformat_line,"\n";
			}

# unpack is the key syntax to reformat a sting and print it out in a fixed length.  Here, we unpack the joined one line $seq into lines $reformat_line with 30 characters (A30) per line followed by any remaining characters * whose length is < 30 characters.  We then print each $reformat_line  followed by a hidden “\n";

	}
  
exit;

