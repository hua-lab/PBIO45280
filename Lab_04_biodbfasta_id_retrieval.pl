
#! usr/bin/perl
use warnings;
use strict;

# You should know what these three lines mean.  If you don’t know, review Lab 2 Part 3.

use Bio::DB::Fasta;

# This is how we call a Perl module in to your program.  How a Perl module is developed edited, and installed is out of the scope of this lab class

my $pep_db=Bio::DB::Fasta->new(“path_to_your_proteome_file”);

# This is an index statement that allows Bio::DB::Fasta to read in your fasta-formated sequence database and save it into a sting, named $pep_db. An arrow symbol is always used in Objective-oriented (OO) programming to call methods. OO programming is also out of the scope of this lab.

my @ids=$pep_db->ids;

# Now, you can see how powerful a Bioperl module is.  You just need one statement to get all sequence IDs and save them into an @ids array.

my @sort_ids=sort {$a cmp $b}@ids;

# You know what sort means.  Here it has the exactly function to sort your ids alphabetically by cmp function and save the sorted IDs into a new array.

my $count=0;

# We will use a count function to record how many protein-coding genes that are annotated in a proteome file.  Before we start counting, we should define and reset the counting number to 0.

foreach my $id(@sort_ids){

	  ++$count;

# Here ++$count equals $count=$count+1.  You may easily understand the latter.  However, in programming, it sometimes adds more jargons into it to shorten the code, very much like many acronyms in biology.  You can also use $count++ or $count += 1 for incrementing counts. 

  	my $length=$pep_db->length($id);

# This is the embedded function of Bio::DB::Fasta module.  It calculates the length of the sequence.

	  print $id,”\t”,$count,”\t”,$length,”\n”;

				}
# We use print to write out the string variables that are separated by a tab symbol “\t”.

exit;
