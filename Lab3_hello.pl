	#! /usr/bin/perl  

# Tells the computer where the perl executable variable is. 

	use warnings; 

# This will allow the Perl to print out any errors in your Perl code. All Perl statement should end up with semi colon symbol except the first sentence.  All pound # signs except the one in the first sentence are used for comments (not executable) in most programming languages, including Perl.
 
	use strict;

 # This restricts all variables in the code should be defined by my when they first appear in your code which can avoid the mixture of different variables with the same name.

	my $hello=”Hello World”; 

# A string is much of a line and it is marked with a dollar $ sign.  Again, any variable should be defined with my when it appears at the first time in the code.

	print $hello,”\n”;

#  Here, you don’t give my to $hello because it has been defined with my as a sentence string of Hello World.  Note that the sentence is quoted by a double prime symbol.

	exit;
