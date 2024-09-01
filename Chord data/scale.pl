#! /usr/bin/perl
# to be started with a THY333 binary dump file as argument
# output: data structures in JSON format
#
use Data::Dumper;
use strict;

# Data structures:
# - Note values
#   . name '-' octave 1..4
#   . value (index)

# set up static notes array
my @notes;
my @note;
my @notes = qw( C C#/Db D D#/Eb E F F#/Gb G G#/Ab A A#/Bb B );
my @octaves = qw( -1 0 1 2 3 4 5 6 7 8 9 );
for (my $i = 0; $i < 127; $i++) {
  $note[$i] = $notes[$i % 12] . $octaves[int($i / 12)];
}

# - Categories
#   . name
#   . offset to Groups
#   . number of Groups
my @categories;

# - Category groups
#   . name
#   . offset to Scales
#   . number of Scales
my @groups;

# - Scales
#   . name
#   . offset to Chords
#   . foo?
#   . index 0..11
#   . chords array 0..63
my @scales;

# - Chords
#   . name
#   . notes[7]
my @chords;

$, = " - ";
my $filepointer = 0;    # current number of bytes read from file
my $endmarker = -1;     # next file position to change data structure
my $mode = 0;           # 0:Categories, 1:Groups, 2:Scales, 3:Chords
my $blocksize = 256;    # size of chunks to be read - depends on data type
my $indexoffset = 0;    # Next array index in dependent data type array
my $duplicates = 0;     # number of multiple names for chords
my $block;
my $scale = 0;

open(FD, $ARGV[0]) or die "Cannot open '" . $ARGV[0] . "' - $!\n";
while(read(FD, $block, $blocksize)) {
  my $found_chord;
  my $scaleoffs;
  $filepointer += $blocksize;
  my $head = $block;    # get rid of trailing zero bytes
  if ($mode < 3) {  # works for $mode 0..2
    my @d = split(/;/, $head);
    my $offs = hex($d[1]);  # offset to sub-category
    if ($endmarker < 0) { # set end of data type if not yet done
      $endmarker = $offs;
    }
    if ($mode == 0 || $mode == 1) { # Categories & Groups
      if ($#d == 2) {  # a valid set?
        # work on category data
        push @categories, { name=>$d[0], offset=>$indexoffset, slots=>$d[2] } if ($mode == 0);
        push @groups, { name=>$d[0], offset=>$indexoffset, slots=>$d[2] } if ($mode == 1);
        $indexoffset += $d[2];
      }
    } elsif ($mode == 2) { # Scales
      if ($#d > 2) { # do not read 0xff unused data
        # work on scale data
        push @scales, { name=>$d[0], foo=>$d[2], slot=>$d[3] };
        $indexoffset++;
      }
    }
  } elsif ($mode == 3) { # Chords
    # work on chord data
    my @c;
    (@c) = $block =~ /(\d{14})(\d\d)(.*)/;
    # add to scale etc.
    if ($c[0] =~ /[1-9]/) { # drop zero/NULL entries
      # Chord entries go up to scaleoffs = 47
      # next 32 are right keypad note entries
      # valid entry. Check if it is already known
      if ($scaleoffs < 48) {
        $found_chord = -1;
        # strip trailing 00 pairs
        (my $n, my $dump) = $c[0] =~ /^((([1-9][1-9])|([1-9]\d)|(\d[1-9]))+)(00)*$/;
        my $key = $n . ';' . $c[2];
        if (@chords > 0) {
          for (my $i = 0; $i < @chords; $i++) {
            if ($key eq $chords[$i]) {
              $found_chord = $i;
              last;
            }
          }
        }
        if ($found_chord < 0) { # nothing found
          push @chords, $key;
          $found_chord = $#chords;
        }
      }
      push @{$scales[$scale]{chords}}, $found_chord . ';' . $c[1];
    } else {
      # note entry
    }
    $scaleoffs++;
    if ($scaleoffs >= 80) { # scales have blocks of up to 64 chords
      $scale++;
      $scaleoffs = 0;
    }
  }
# did we get past the data type?
  if ($endmarker > 0 && $filepointer >= $endmarker) {
    $endmarker = -1;
    # advance data type
    $mode++;
    # for chords change data block size
    if ($mode == 3) {
      $blocksize = 32;
      $scale = 0;
      $scaleoffs = 0;
      $endmarker = @scales * 2560;
    }
    # restart index offset
    $indexoffset = 0;
  }
}
close(FD);
print "Categories: $#categories\n";
# print Dumper(\@categories);
print "Groups: $#groups\n";
# print Dumper(\@groups);
print "Scales: $#scales\n";
# print Dumper(\@scales);
print "Chords: $#chords\n";
# print Dumper(\@chords);

# Check chords for correctness
my $last_k = 'NIL';
my $last_n = 'NIL';
foreach my $c (sort @chords) {
  (my $k, my $n) = split(/;/, $c);
  if ($last_k eq $k) {
    if ($last_n ne $n) {
      my $out = sprintf("Two names: '%-16.16s', '%-16.16s' for ", $last_n, $n);
      print $out . "        " . &notenames($k) . "\n";
      $duplicates++;
    } 
  }
  ($last_k, $last_n) = ($k, $n);
}
print "$duplicates multiple chord names\n";

# Now recombine the read data

sub notenames {
  my $rc;
  my $nstr;
  my $n;
  my @n;
  foreach $nstr ( @_ ) {
    @n = $nstr =~ /(\d\d)/g;
    foreach $n (@n) {
      $rc .= $note[$n + 0] . ', ';
    }
  }
  return $rc;
}