#!/usr/bin/perl

use strict;
use Ace;

if ($#ARGV !=2) {
    die "usage: $0 series_file ace\n";
}

print "Data status changes ...\n";
my %OldStats;
my %NewStats;
my %StatsExist;
#my %StatsDiff;
my ($line, $key, $value, $diff);

open (IN, "<$ARGV[0]") || die "can't open $ARGV[0]!";
while ($line = <IN>) {
    chomp ($line);
    ($key, $value) = split ": ", $line;
    $OldStats{$key} = $value;
    $StatsExist{$key} = 1;
}
close (IN);


open (IN, "<$ARGV[1]") || die "can't open $ARGV[1]!";
open (OUT, ">$ARGV[2]") || die "can't open $ARGV[2]!";
while ($line = <IN>) {
    chomp ($line);
    ($key, $value) = split ": ", $line;
    $NewStats{$key} = $value;
    if ($StatsExist{$key}) {
	$diff = $NewStats{$key} - $OldStats{$key};
	print OUT "$key: $OldStats{$key} --\> $NewStats{$key}, $diff added.\n";
    }
}
close (IN);
close (OUT);
print "Done.\n";





