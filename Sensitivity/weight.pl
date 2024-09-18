#! /usr/bin/perl
use strict;
use Data::Dumper;

$| = 1;
my $lastval = 0;
my $samplecnt = 0;
my $rounds = 0;
my $sum = 0;
my $samples = 80;
my $throw_away = 10;
while (<STDIN>) {
  (my $val) = $_=~/Pitch Wheel *(\d+)/;
  (my $key) = $_=~/Note Off *(\d+)/;
  if ($val > 0) {
    $val -= 8192;
    if ($samplecnt > 0) {
      $sum += $val if $samplecnt < $samples;
      $samplecnt--;
      if ($samplecnt == 0) {
        printf("%3d; %5d\n", $rounds, $sum/$samples);
        $sum = 0;
        $rounds++;
      }
    }
  } 
  if ($key == 21) {
    $samplecnt = $samples + $throw_away;
  }
  last if ($key == 23);
}