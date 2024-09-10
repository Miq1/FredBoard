#! /usr/bin/perl
# to be started with a THY333 binary dump file as argument
# output: data structures in JSON format
#
use Data::Dumper;
use Data::HexDump;
use Class::Struct;
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
struct( Category => {
    name => '$',
    offset => '$',
    groups => '$'
});

# - Category groups
#   . name
#   . offset to Scales
#   . number of Scales
my @groups;
struct( Group => {
    name => '$',
    offset => '$',
    scales => '$'
});

# - Scales
#   . name
#   . foo?
#   . index 0..11
#   . chords array 0..47
#   . notes array 0..31
my @scales;
struct( Scale => {
    name => '$',
    foo => '$',
    index => '$',
    chords => '@',
    notes => '@'
});

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
my $scaleoffs = 0;

open(FD, $ARGV[0]) or die "Cannot open '" . $ARGV[0] . "' - $!\n";
while(read(FD, $block, $blocksize)) {
  my $found_chord;
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
        push @categories, Category->new( name=>$d[0], offset=>$indexoffset, slots=>$d[2]) if ($mode == 0);
        push @groups, Group->new( name=>$d[0], offset=>$indexoffset, slots=>$d[2] ) if ($mode == 1);
        $indexoffset += $d[2];
      }
    } elsif ($mode == 2) { # Scales
      if ($#d > 2) { # do not read 0xff unused data
        # work on scale data
        (my $inx) = $d[3]=~/^(\d+)/;
        push @scales, Scale->new( name=>$d[0], foo=>$d[2], index=>$inx );
        $indexoffset++;
      }
    }
  } elsif ($mode == 3) { # Chords
    # work on chord data
    my @c;
    (@c) = $block =~ /(\d{14})(\d\d)([ -z]*)/;
    # add to scale etc.
    if ($c[0] =~ /[1-9]/) { # drop zero/NULL entries
      # Chord entries go up to scaleoffs = 47
      # next 32 are right keypad note entries
      # valid entry. Check if it is already known
      # strip trailing 00 pairs
      (my $n, my $dump) = $c[0] =~ /^((([1-9][1-9])|([1-9]\d)|(\d[1-9]))+)(00)*$/;
      if ($scaleoffs < 48) {
        $found_chord = -1;
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
        push @{$scales[$scale]->chords}, $found_chord . ';' . $c[1];
      } else {
        # note entry
        push @{$scales[$scale]->notes}, $n + 0 . ';' . $c[1];
      }
      # printf("Scale %3d: %3d c, %3d n\n", $scale, $#{$scales[$scale]->chords}, $#{$scales[$scale]->notes});
    }
    $scaleoffs++;
    if ($scaleoffs >= 80) { # scales have blocks of up to 48 chords and 32 notes
      $scale++;
      $scaleoffs = 0;
    }
  }
# did we get past the data type?
  if ($mode < 3 && $endmarker > 0 && $filepointer >= $endmarker) {
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
      my $out = sprintf("Two names: '%-16s', '%-16s' for ", $last_n, $n);
      print $out . "        " . &notenames($k) . "\n";
      $duplicates++;
    } 
  }
  ($last_k, $last_n) = ($k, $n);
}
print "$duplicates multiple chord names\n";

my $cscale;
my $cnote;
my @noteset;
my @octaves;
foreach $cscale (@scales) {
  print $cscale->name, "\n";
  @noteset = ();
  @octaves = ();
  # Count notes and octaves used
  foreach $cnote (@{$cscale->notes}) {
    $noteset[$cnote % 12]++;
    $octaves[int($cnote / 12)]++;
  }
  # Check scales for 4 matching sets of notes
  for (my $i = 0; $i <= $#noteset; $i++) {
    if ($noteset[$i] > 0) {
      print $notes[$i];
      if ($noteset[$i] != 4) {
        print " OOPS: $noteset[$i]";
      }
      print " ";
    }
  }
  print "\n";
}



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

sub strippednotes {
  my $rc;
  my $nstr;
  my $n;
  my @n;
  foreach $nstr ( @_ ) {
    @n = $nstr =~ /(\d\d)/g;
    foreach $n (@n) {
      $rc .= $notes[$n % 12] . ', ';
    }
  }
  return $rc;
}