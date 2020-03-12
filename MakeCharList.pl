#!/usr/bin/perl

# MakeCharList.pl

our $Version = "3.0";	# 2005-10-15 bh
#	Added -f and -r options
# Version 2: 21 Sep 05 jw v2 modified layout of output file
# Version 1: 16 Aug 05  bb

use Getopt::Std;

our ($opt_f, $opt_r);
getopts('fr');

die <<"eof" unless $#ARGV >= 0;
Usage:
    MakeCharList.pl [-f] [-r]  infile > outfile

Given a legacy text file, count the number of times each character occurs.
Print out the count, also giving the decimal equivalent of each character.
The characters themselves are printed twice, so that in Word, one column 
can be left in Courier, and the other can be converted to a legacy font,
for easy review.

-f sort by frequency

-r reverse sort order

Version $Version
eof

while ($line = <>) {
	chomp $line;
	@chars = split(//, $line);
	for ($i=0; $i<=$#chars; $i++) {
		$count[ord($chars[$i])]++;
		}
	}

my @list = (0 .. 255);
@list = sort {$count[$a] <=> $count[$b]} @list if $opt_f;
@list = reverse @list if $opt_r;

print "Dec\tHex\tCour\tLegacy\tCount\n";
for $i (@list) {
	$c = chr($i);
	if ($count[$i]) {
		printf "%3d\tx%04X\t$c\t$c\t%5g\n", $i, $i, $count[$i];
		}
	}
	
