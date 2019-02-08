#! /usr/bin/perl
#
use warnings;
use strict;

use Bio::DB::Fasta;

my $db=Bio::DB::Fasta->new("skp1_peps_in_10_species.fa");

my @ids=$db->ids;

my @species;

foreach my $id(@ids){
	my $species_id=substr($id,0,2);
	# substr is a syntax to extrat a certain length strin from a string.  Here the string is $id
	# extraction begins position 0 (i.e., the gegning of $id), extraction length is 3 characters
	push(@species,$species_id);

}


my %hash;
my @unique_species_ids;

foreach my $species_id(@species){

	if(!$hash{$species_id}){

		push(@unique_species_ids,$species_id);
			
				}
	$hash{$species_id}="true";

				}

#sounds familiar with the above module?
#
my @yeast_unique_species_ids;
my @worm_unique_species_ids;
#the ids of these two species are very similar and do not share a unique pattern for their gene IDs. 
#We deal with them later

foreach my $unique_species_id(@unique_species_ids){

	if($unique_species_id=~/^Y/i){
		push(@yeast_unique_species_ids,$unique_species_id);
			next;
			}

	if($unique_species_id=~/\w\d/){
		push(@worm_unique_species_ids,$unique_species_id);
			next;
			}

	else{

		my $species_id_count=0;

		foreach my $id(@ids){
			if($id=~/$unique_species_id/){
				++$species_id_count;
				my $new_id=$unique_species_id."SKP_".$species_id_count;
				my $pep_obj=$db->get_Seq_by_id($id);
				my $pep=$pep_obj->seq;
				print ">",$new_id," \| ",$id,"\n";
				print $pep,"\n";
						
				}
			}

		}
	}
		
#deal with yeast SKP1s

my $yeast_species_id_count=scalar @yeast_unique_species_ids;

my $yeast_skp1_count=0;

for(my $i=0; $i<$yeast_species_id_count; ++$i){

	my $yeast_species_id=$yeast_unique_species_ids[$i];
	
	foreach my $id(@ids){
		if($id=~/$yeast_species_id/){
				++$yeast_skp1_count;
				my $new_id="CsaSKP_".$yeast_skp1_count;
				my $pep_obj=$db->get_Seq_by_id($id);
				my $pep=$pep_obj->seq;
				print ">",$new_id," \| ",$id,"\n";
				print $pep,"\n";
						
				}

			}

	}

# deal with worm SKP1s

my $worm_species_id_count=scalar @worm_unique_species_ids;

my $worm_skp1_count=0;

for(my $i=0; $i<$worm_species_id_count; ++$i){

	my $worm_species_id=$worm_unique_species_ids[$i];
	
	foreach my $id(@ids){
		if($id=~/$worm_species_id/){
				++$worm_skp1_count;
				my $new_id="CelSKP_".$worm_skp1_count;
				my $pep_obj=$db->get_Seq_by_id($id);
				my $pep=$pep_obj->seq;
				print ">",$new_id," \| ",$id,"\n";
				print $pep,"\n";
						
				}

			}



	}



exit;
