#! /usr/bin/perl 
use strict;
use warnings;

# You should be able to the functions of these three statements now.

# Review Part 2 for the –outfmt 6 function, which writes out the BLASTP results as a tab file.  The first column is the query IDs and the second column shows the hit IDs.

# Below, we will ask Perl to open a blastp output file, find all hit ids (the second column), and save the hit ids into an array variable, @blastp_parse_ids.

open BLASTP_OUT,"<../blastp_outputs/skp1_at_blastp"; 

# open is a Perl syntax to read in a file

my @blastp_parse_ids; 

# my defines a new array

while(my $parse=<BLASTP_OUT>){ 

# my defines a new string.  While is a Perl syntax to read each line in the file one by one
	
	chomp $parse; 

# chomp removes the hidden new line symbol “\n” or its cousins linefeeds and carriage returns. Keep in mind, in programming, any symbols, including those hidden ones could make you very frustrated because they are all meaningful and should be carefully treated.  
	
	my @parses=split /\t/,$parse; 

# This is a useful statement which converts a string, $parse, into, an array by splitting the string into pieces at each tab symbol, \t.  Remember, the BLASTP output file is a tab file.
	my $hit_id=$parses[1];
	
# Again, the hit ids are in the second column of each line.  Because in most programming languages, counting begins 0.  Thus, the second is counted as 1.

	push(@blastp_parse_ids,$hit_id); 

# Save all hit IDs into the array and many are duplicated

		}

close BLASTP_OUT;
	
# After finish reading the file, the file should be closed. 
	
# The codes below will apply the unique variable property of the key variables in a hash to retrieve unique HIT IDS

my %hash;
my @unique;

# my define a new hash

foreach my $hit_id(@blastp_parse_ids){

# foreach is a syntax to read each string of an array one by one 

    if (!$hash{$hit_id}) {    
        
 	 push (@unique, $hit_id);
          $hash{$hit_id} = "true";

               }

# If a string (key) is not assigned (the syntax “!” means “no” in Perl) to a value (here is an artificial string “true”), 
# we will assign it to “true”.  $hash{$hit_id} = "true" is a structure to write a hash. Here, $hash calls %hash in and asks 
# %hash to assign a “true” value to the key variable, $hit_id. However, if a key ($hit_id here) variable has already been 
# assigned as a “true” value in a previous string read in by foreach, it will be memorized in the hash %hash and will be 
# ignored by the if syntax.  Again, “!” means “no”.
	
	}

# Each loop needs to be separated by brackets.  Thus the functions in the loop will finish first.

my @unique_hit_ids=keys %hash;

# keys reads all key variables of a hash and saves it into an array.

foreach my $unique_id(@unique_hit_ids){

	print $unique_id,"\n";

	}
#print out the result and each id will be printed in one line

exit;

#  exit turns off the progrm
