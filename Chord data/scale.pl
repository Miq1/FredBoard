#! /usr/bin/perl
# to be started with a THY333 binary dump file as argument
# output: data structures in JSON format
#
use Data::Dumper;

# Data structures:
# - Note values
#   . name '-' octave 1..4
#   . value (index)

# set up static notes array
my @notes;
my @note;
for ($i = 0; $i < 88; $i++) { $note[$i] = 'What?-' . $i; }
@notes = qw( F#/Gb G G#/Ab A A#/Bb B C C#/Db D D#/Eb E F ) ;
for ($i = 0; $i < 12; $i++) {
  $note[30 + $i] = $notes[$i] . '-1';
  $note[42 + $i] = $notes[$i] . '-2';
  $note[54 + $i] = $notes[$i] . '-3';
  $note[66 + $i] = $notes[$i] . '-4';
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
$filepointer = 0;    # current number of bytes read from file
$endmarker = -1;     # next file position to change data structure
$mode = 0;           # 0:Categories, 1:Groups, 2:Scales, 3:Chords
$blocksize = 256;    # size of chunks to be read - depends on data type
$indexoffset = 0;    # Next array index in dependent data type array
$duplicates = 0;     # number of multiple names for chords

open(FD, $ARGV[0]) or die "Cannot open '" . $ARGV[0] . "' - $!\n";
while(read(FD, $block, $blocksize)) {
  $filepointer += $blocksize;
  $head = $block;    # get rid of trailing zero bytes
  if ($mode < 3) {  # works for $mode 0..2
    @d = split(/;/, $head);
    $offs = hex($d[1]);  # offset to sub-category
    if ($endmarker < 0) { # set end of data type if not yet done
      $endmarker = $offs;
    }
    if ($mode == 0 || $mode == 1) { # Categories & Groups
      if ($#d == 2) {  # a valid set?
        # work on category data
        push @categories, { name=>$d[0], offset=>$indexoffset, slots=>$d[2] } if ($mode == 0);
        push @groups, { name=>$d[0], offset=>$indexoffset, slots=>$d[2] } if ($mode == 1);
        $indexoffset += $d[2];
        # print $mode, $d[0], $offs, $d[2], "\n";
      }
    } elsif ($mode == 2) { # Scales
      if ($#d > 2) { # do not read 0xff unused data
        # work on scale data
        push @scales, { name=>$d[0], foo=>$d[2], slot=>$d[3] };
        # print $mode, $d[0], $offs - $indexoffset, $d[2], $d[3], "\n";
        $indexoffset++;
      }
    }
  } elsif ($mode == 3) { # Chords
    # work on chord data
    (@c) = $block =~ /(\d{14})(\d\d)(.*)/;
    # add to scale etc.
    # print "'$c[0]'\n";
    if ($c[0] =~ /[1-9]/) { # drop zero/NULL entries
      # valid entry. Check if it is already known
      $found_chord = -1;
      if (@chords > 0) {
        for ($i = 0; $i < @chords; $i++) {
          if ($c[0] eq $chords[$i]{key}) {
            $found_chord = $i;
            if ($chords[$i]{name} ne $c[2]) { # different name, same chord?
              warn "Additional name '" . $c[2] . "' for '" . $chords[$i]{name} . "' (" . $chords[$i]{key} . ")\n";
              $duplicates++;
            }
            break;
          }
        }
      }
      # print "fc=$found_chord\n" if $found_chord >= 0;
      if ($found_chord < 0) { # nothing found
        push @chords, { key=>$c[0], name=>$c[2] };
        $found_chord = $#chords;
      }
    }
    # push $scales[$scale]{chords}, $chord;
    $scaleoffs++;
    if ($scaleoffs >= 64) { # scales have blocks of up to 64 chords
      $scale++;
      $scaleoffs = 0;
    }
    # print @c, "\n";
  }
# did we get past the data type?
  if ($endmarker > 0 && $filepointer >= $endmarker) {
    $endmarker = -1;
    # advance data type
    $mode++;
    print "$mode\n";
    # for chords change data block size
    if ($mode == 3) {
      $blocksize = 32;
      $scale = 0;
      $scaleoffs = 0;
      $endemarker = @scales * 2560;
    }
    # restart index offset
    $indexoffset = 0;
  }
}
close(FD);
print "Categories: $#categories\n";
print Dumper(\@categories);
print "Groups: $#groups\n";
print Dumper(\@groups);
print "Scales: $#scales\n";
print Dumper(\@scales);
print "Chords: $#chords\n";
print Dumper(\@chords);
print "$duplicates multiple chord names\n";

# Now recombine the read data

