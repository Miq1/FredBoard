#! /usr/bin/perl
use strict;
use Data::Dumper;

$| = 1;
my $lastval = 0;
while (<STDIN>) {
  (my $val) = $_=~/Pitch Wheel *(\d+)/;
  $val -= 8192;
  # if ($val > 0 && $val != $lastval) {
    printf("%5d\n", $val) if $val > 0;
    # $lastval = $val;
  # }
}