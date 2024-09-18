#! /usr/bin/perl
use strict;
use Data::Dumper;

my $center;
my $spread;
my $steepness;
my $reduce = 1;
my $samples;

die "Usage: playground.pl <center> <spread> <steepness> [<samples>]\n" unless $#ARGV >= 2;

($center, $spread, $steepness, $samples) = @ARGV;

my @correction;
my @linear;
# my $val;
# Set initial even distribution as default
for (my $i = 0; $i < 4096; $i++) {
  # $correction[$i] = $val;
  $correction[$i] = $i;
  # if ($i % 32 == 31) {
    # $val += 32;
  # }
}
@linear = @correction;

# If we have a center value, we will adapt the distribution
if ($center) {
  my $ramp = 0;
  my $dir = $steepness > 0 ? 1 : -1;
  $steepness *= $dir;
  for (my $i = $center; $i < 4096; $i++) {
    $correction[$i] += $ramp;
    $correction[$i] = 4095 if $correction[$i] > 4095;
    $correction[$i] = 0 if $correction[$i] < 0;
    if ($dir > 0) {
      $ramp += $steepness unless $ramp >= $spread;
    } else {
      $ramp -= $steepness unless $ramp <= $spread;
    }
  }
}

# Print out result
if (0) {
  my $s = 0;
  my $cnt = 0;
  my $from = 0;
  for (my $i = 0; $i < 4096; $i++) {
    if ($correction[$i] != $s) {
      printf("%3d: %4d from %d\n", $s, $cnt, $from);
      $s = $correction[$i];
      $cnt = 0;
      $from = $i;
    } else {
      $cnt++;
    }
  }
  printf("%3d: %4d\n", $s, $cnt);
}

my @statistics;
my @linear_statistics;
my $statcount;
while (<STDIN>) {
  last if $samples > 0 && $statcount > $samples;
  (my $val) = $_=~/(\d+)/;
  $val -= 9192;
  print $val, "-> ", $correction[$val], "\n";
  $statcount++;
  $statistics[$correction[$val] >> 5]++;
  $linear_statistics[$val >> 5]++;
}

for(my $i = 0; $i < @statistics; $i++) {
  printf("%3d; %5.2f; %5.2f\n", $i, $statistics[$i]/$statcount*100.0, $linear_statistics[$i]/$statcount*100.0);
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