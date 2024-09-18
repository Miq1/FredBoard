#! /usr/bin/perl
use strict;
use Data::Dumper;

(my $samples) = shift;

my @statistics;
my $statcount;
while (<STDIN>) {
  (my $val) = $_=~/(\d+)/;
  $val -= 8192;
  $statcount++;
  $statistics[$val]++;
  last if $statcount > $samples;
}

for(my $i = 0; $i < @statistics; $i++) {
  printf("%3d; %5.2f\n", $i, $statistics[$i]/$statcount*100.0);
}

sub min {
    my $min = shift;
    foreach (@_) {
        $min = $_ if $_ < $min;
    }
    return $min;
}

sub max {
    my $max = shift;
    foreach (@_) {
        $max = $_ if $_ > $max;
    }
    return $max;
}