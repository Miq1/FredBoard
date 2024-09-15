#! /usr/bin/perl
use strict;
use Data::Dumper;

my $center;
my $spread;
my $rule;
my $reduce = 1;

die "Usage: playground.pl <center> <spread> <rule>\n" unless $#ARGV == 2;

($center, $spread, $rule) = @ARGV;
die "center must be [0..4095]\n" unless $center >= 0 && $center <= 4095;
die "spread must be [0..255]\n" unless $spread >= 0 && $spread <= 255;
die "rule must be float [0..31]\n" unless $ rule >= 0 && $ rule <= 31;

my @correction;
my $val;
# Set initial even distribution as default
for (my $i = 0; $i < 4096; $i++) {
  $correction[$i] = $ val;
  if ($i % 32 == 31) {
    $val++;
  }
}

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
    $reduce *= $rule;
    # get new left and right boundaries
    $left_bound -= $spread;
    $right_bound += $spread;
    # adjust left and right values
    $lvalue--; 
    $lvalue = 0 if $lvalue < 0;
    $rvalue++; 
    $rvalue = 127 if $rvalue > 127;
  } while ($spread > 0 && $left_bound >= 0 && $right_bound <= 4095);
}

# Print out result
for (my $i = 0; $i < 4096; $i++) {
  printf("%0d, ", $correction[$i]);
  print "\n" if ($i % 16 == 15);
}

my @statistics;
while (<STDIN>) {
  (my $val) = $_ + 0;
  $statistics[$correction[$val]]++;
}

for(my $i = 0; $i < @statistics; $i++) {
  printf("%3d: %d\n", $i, $statistics[$i]);
}