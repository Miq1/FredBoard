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
die "center must be [0..4095]\n" unless $center >= 0 && $center <= 4095;
die "spread must be [0..255]\n" unless $spread >= 0 && $spread <= 255;
die "steepness must be float [-31..31]\n" unless $ steepness >= -31 && $ steepness <= 31;

my @correction;
my @linear;
my $val;
# Set initial even distribution as default
for (my $i = 0; $i < 4096; $i++) {
  $correction[$i] = $ val;
  if ($i % 32 == 31) {
    $val++;
  }
}
@linear = @correction;

# If we have a center value, we will adapt the distribution
if ($center) {
  # get initial boundaries and value to be set
  my $left_bound = $center - $spread/2;
  my $right_bound = $center + $spread/2;
  my $lvalue = $correction[$center];
  my $rvalue = $correction[$center];
  my $had_one;
  # Starting with the center interval, loop over the whole array
  # in intervals left and right to the last one written
  do {
    # printf("%d: %d=%d - %d - %d=%d\n", $had_one, $left_bound, $lvalue, $spread, $right_bound, $rvalue);
    $had_one = 0;
    # Left interval
    for (my $i = &max(0, $left_bound); $i < &min(4095, $left_bound + $spread); $i++) {
      $correction[$i] = $lvalue;
      # printf("l=%d -> %d\n", $i, $lvalue);
      $had_one = 1;
    }
    # Right interval
    for (my $i = &min(4095, $right_bound); $i > &max(0, $right_bound - $spread); $i--) {
      $correction[$i] = $rvalue;
      # printf("r=%d -> %d\n", $i, $rvalue);
      $had_one = 1;
    }
    # now recalculate the interval
    $spread *= $steepness;
    # adjust left and right values
    $lvalue = $correction[&max(0, $left_bound - $spread/2 - 1)];
    $lvalue = 0 if $lvalue < 0;
    $rvalue = $correction[&min(4095, $right_bound + $spread/2 + 1)];
    $rvalue = 127 if $rvalue > 127;
    # get new left and right boundaries
    $left_bound -= $spread;
    $right_bound += $spread;
    # loop until there was no change or the interval size has dropped to zero
  } while ($had_one > 0 && int($spread) > 0);
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
while (<STDIN> && ($samples == 0 || $statcount < $samples)) {
  (my $val) = $_=~/(\d+)/;
  $statcount++;
  $statistics[$correction[$val]]++;
  $linear_statistics[$correction[$val]]++;
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