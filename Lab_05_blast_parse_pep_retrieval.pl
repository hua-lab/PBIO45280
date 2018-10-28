#! /usr/bin/perl

use warnings;
use strict;
use Bio::DB::Fasta;

my $pep_db=Bio::DB::Fasta->new(“path_to_your_target_proteome_file”);

open BLAST_PARSE,”<one_of_your_blast_parse_file”;

while(my $parse_id=< BLAST_PARSE>){

	  chomp $parse_id;

# You should know the functions of all the above statements now

	  my $pep_obj=$pep_db->get_Seq_by_id($parse_id);

# You may have already known that all Bioperl modules are OO programming.  One function of OO programming is to call an objective, which is composed of ###.  You may just need to know now that in order to retrieve a sequence, we call an objective first using the sequence ID.

	  my $pep=$pep_obj->seq;

# OO programming allows to retrieve the sequence of a target ID through its objective, $seq_obj, and a method, seq.

	  print “>”,$parse_id,”\n”;
       	  print  $pep,”\n”;

# For each homologous protein, we print out its sequence in a fasta format.

  } 

# Use a while loop to get all homologous sequence in a targeted proteome database.

	close BLAST_PARSE;

# After finish reading the file, the file should be closed. 

	exit;
