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
  my $left_bound = $center - $spread/2;
  my $right_bound = $center + $spread/2;
  my $lvalue = $correction[$center];
  my $rvalue = $correction[$center];
  # Starting with the center interval, loop over the whole array
  # in decreasing interval halfs left and right to the last one written
  do {
    # printf("%d=%d - %d - %d=%d\n", $left_bound, $lvalue, $spread, $right_bound, $rvalue);
    # Left interval
    foreach my $i ($left_bound .. $left_bound + $spread) {
      if ($i >= 0 && $i <= 4095) {
        $correction[$i] = $lvalue;
      }
    }
    # Right interval
    foreach my $i ($right_bound - $spread .. $right_bound) {
      if ($i >= 0 && $i <= 4095) {
        $correction[$i] = $rvalue;
      }
    }
    # now reduce the spread
    $spread -= $reduce;
    # dynamically shorten intervals
    $reduce += $steepness;
    # get new left and right boundaries
    $left_bound -= $spread;
    $right_bound += $spread;
    # adjust left and right values
    $lvalue--; 
    $lvalue = 0 if $lvalue < 0;
    $rvalue++; 
    $rvalue = 127 if $rvalue > 127;
  } while ($left_bound+$spread >= 0 && $right_bound-$spread <= 4095);
  # } while ($spread > 0 && $left_bound >= 0 && $right_bound <= 4095);
}

# Print out result
for (my $i = 0; $i < 4096; $i++) {
  printf("%0d, ", $correction[$i]);
  print "\n" if ($i % 16 == 15);
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