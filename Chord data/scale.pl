#! /usr/bin/perl
# to be started with a THY333 binary dump file as argument
# output: data structures in JSON format
#         warnings/errors/hints in 'errorlist.txt'
#
use Data::Dumper;
use Data::HexDump;
use Class::Struct;
use strict;

# Data structures:
# note names
my @notes = qw( C C# D D# E F F# G G# A A# B );
# alternate names for the half tones
my @altnotes = qw( nil Db nil Eb nil nil Gb nil Ab nil Bb nil );
my @octaves = qw( -1 0 1 2 3 4 5 6 7 8 9 );
# set up static notes array
my @note;
# Assign the names to all MIDI notes
for (my $i = 0; $i < 127; $i++) {
  $note[$i] = $notes[$i % 12] . $octaves[int($i / 12)];
}

# - Categories
#   . name
#   . offset to into Groups array
#   . number of Groups
my @categories;
struct( Category => {
    name => '$',
    offset => '$',
    groups => '$'
});

# - Category groups
#   . name
#   . offset to Scales array
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
#   . chords array 0..47 containing chord index and color group
#   . notes array 0..31 as chords
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
#   . id is index in chords array for easier reference
#   . warning will be set != 0 if an error was found regarding the chord
my @chords;
struct( Chord => {
    name => '$',
    notes => '$',
    warning => '$',
    id => '$'
});

$, = " - ";
my $filepointer = 0;    # current number of bytes read from file
my $endmarker = -1;     # next file position to change data structure
my $mode = 0;           # 0:Categories, 1:Groups, 2:Scales, 3:Chords and notes
my $blocksize = 256;    # size of chunks to be read - depends on data type
my $indexoffset = 0;    # Next array index in dependent data type array
my $scale = 0;          # in scale mode counts the number of scales collected
my $scaleoffs = 0;      # count of chords/notes within a scale

open(ERRORLIST, '>', 'errorlist.txt') or die "Cannot write to 'errorlist.txt' - $!\n";

open(FD, $ARGV[0]) or die "Cannot open '" . $ARGV[0] . "' - $!\n";
while(read(FD, my $block, $blocksize)) {
  my $found_chord;
  $filepointer += $blocksize;
  (my $head) = $block=~/^([^\x00]*)/;    # get rid of trailing zero bytes
  if ($mode < 3) {  # works for $mode 0..2
    my @d = split(/;/, $head);
    my $offs = hex($d[1]);  # offset to sub-category
    if ($endmarker < 0) { # set end of data type if not yet done
      $endmarker = $offs;
    }
    if ($mode == 0 || $mode == 1) { # Categories & Groups
      if ($#d == 2) {  # a valid set?
        # work on category data
        push @categories, Category->new( name=>$d[0], offset=>$indexoffset, groups=>$d[2]) if ($mode == 0);
        push @groups, Group->new( name=>$d[0], offset=>$indexoffset, scales=>$d[2] ) if ($mode == 1);
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
        # chord entry
        $found_chord = -1;
        my $key = &unifiedname($c[2]);
        if (@chords > 0) {
          for (my $i = 0; $i < @chords; $i++) {
            if ($chords[$i]->name eq $key && $chords[$i]->notes eq $n) {
              $found_chord = $i;
              last;
            }
          }
        }
        if ($found_chord < 0) { # nothing found
          $found_chord = $#chords + 1;
          push @chords, Chord->new( name => $key, notes => $n, warning => '', id => $found_chord );
        }
        push @{$scales[$scale]->chords}, $found_chord . ';' . $c[1];
      } else {
        # note entry
        push @{$scales[$scale]->notes}, $n + 0 . ';' . $c[1];
      }
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
print ERRORLIST "Chord checks\n";
print ERRORLIST "============\n";
my $duplicates = 0;     # number of multiple names for chords
my $last_k = 'NIL';
my $last_n = 'NIL';
foreach my $c (sort { $a->notes cmp $b->notes } @chords) {
  my $k = $c->notes;
  my $n = $c->name;
  if ($last_k eq $k) {
    if ($last_n ne $n) {
      my $out = sprintf(">>>> name trouble: '%-16s', '%-16s' for ", $last_n, $n);
      print ERRORLIST $out . "        " . &notenames($k) . "\n";
      if ($c->warning ne '') {
        $c->warning($c->warning . ", $last_n");
      } else {
        $c->warning($c->warning . "check $last_n");
      }
      $duplicates++;
    } 
  }
  ($last_k, $last_n) = ($k, $n);
}
print ERRORLIST "$duplicates multiple chord names\n\n";

print ERRORLIST "Scale checks\n";
print ERRORLIST "============\n";
my $cnote;
my $cname;
my $cchord;
my @noteset;
my @octaves;
my $errinfo;
foreach my $cscale (@scales) {
  $errinfo =  $cscale->name . "(";
  @noteset = ();
  @octaves = ();
  # Count notes and octaves used
  foreach $cnote (@{$cscale->notes}) {
    $noteset[$cnote % 12]++;
    $octaves[int($cnote / 12)]++;
  }
  # Check scales for 4 matching sets of notes
  my @oops = ();
  for (my $i = 0; $i <= $#noteset; $i++) {
    if ($noteset[$i] > 0) {
      $errinfo .= $notes[$i] . ' ';
      if ($noteset[$i] != 4) {
        push @oops, $i;
      }
    }
  }
  $errinfo .= ")";
        
  if (@oops > 0) {
    print ERRORLIST "$errinfo\n";
    foreach my $oops (@oops) {
      print ERRORLIST ">>>> note count not 4: $notes[$oops]: $noteset[$oops]\n";
    }
  }

  my $ocnt = 0;
  my $o;
  my $continuous = 0;
  foreach $o (@octaves) {
    if ($o > 0) {
      $ocnt++;
      $continuous++;
    } else {
      if ($continuous) {
        print ERRORLIST "$errinfo\n>>>> OOPS: octave gap?\n";
      }
    }
  }
  # Check scales for 4 increasing octaves
  if ($ocnt < 4 || $ocnt > 5) {
    print ERRORLIST "$errinfo\n>>>> OOPS: octave count: $ocnt ";
    for (my $i = 0; $i <= $#octaves; $i++) {
      if ($octaves[$i] > 0) {
        printf(ERRORLIST " O%d: %d ", $i, $octaves[$i]);
      }
    }
    print ERRORLIST "\n";
  }

  # check chords for the use of the scale's notes
  foreach $cchord (@{$cscale->chords}) {
    my $id;
    my $slot;
    ($id, $slot) = split(/;/, $cchord);
    my @d= ();
    my $keys = $chords[$id]->notes;
    $cname = $chords[$id]->name;
    @d = $keys=~/^(\d\d)+/;
    my $n;
    foreach $n (@d) {
      $n %= 12;
      if ($noteset[$n] <= 0) {
        printf(ERRORLIST "$errinfo\n>>>> Chord %d (%s, %s), off-scale note: %s\n", $id, $cname, &strippednotes($keys), $notes[$n]);
        # $chords[$id]->warning($chords[$id]->warning . "off scale: $notes[$n] ");
        $cchord .= ';' . $notes[$n];
      }
    }
  }
}

# name all chords with findings
print ERRORLIST "\nChords requiring a check\n";
print ERRORLIST "========================\n";
foreach my $c (@chords) {
  if ($c->warning ne '') {
    printf(ERRORLIST "%4d %-12s (%s)\n", $c->id, $c->name, &notenames($c->notes));
  }
}

close(ERRORLIST);

# Put out the data as JSON
open(JSONFILE, '>', 'scales.json') or die "Cannot write to 'scales.json' - $!\n";

my $indentwidth = 2;
my $indent = 0;
printf(JSONFILE "{\n");
# Chords are the first section
$indent += $indentwidth;
printf(JSONFILE ' ' x $indent . "\"Chords\" : [\n");

my $hadchord = 0;
$indent += $indentwidth;
foreach my $c (@chords) {
  printf(JSONFILE ",\n") if $hadchord;
  printf(JSONFILE ' ' x $indent . "{ ");
  printf(JSONFILE "\"name\": %-16s, ", '"' . $c->name . '"');
  # Separate notes, get the plain note names
  printf(JSONFILE "\"notes\": [");
  my @d = $c->notes=~/(\d\d)/g;
  my $hadone = 0;
  foreach my $n (@d) {
    printf(JSONFILE ", ") if $hadone;
    printf(JSONFILE "\"%s\"", $notes[$n % 12]);
    $hadone = 1;
  }
  printf(JSONFILE "]");
  # If there was a warning, put it out
  if ($c->warning ne '') {
    printf(JSONFILE ",\n" . ' ' x $indent . "  \"_warning\": \"%s\"", $c->warning);
  }
  printf(JSONFILE ' ' x $indent . "}");
  $hadchord = 1;
}
$indent -= $indentwidth;
printf(JSONFILE "\n" . ' ' x $indent . "],\n");

# Next are scales in groups
my $hadgroup = 0;
printf(JSONFILE ' ' x $indent . "\"Scales\" : [\n");
# Level 1: group
$indent += $indentwidth;
foreach my $group (@groups) {
  my $hadscale = 0;
  printf(JSONFILE ",\n") if $hadgroup;
  printf(JSONFILE ' ' x $indent . "{ \"name\": \"%s\",\n", $group->name);
  $indent += $indentwidth;
  printf(JSONFILE ' ' x $indent . "\"group\": [\n", $group->name);
  # Level 2: scale
  $indent += $indentwidth;
  for (my $i = $group->offset; $i < $group->offset + $group->scales; $i++) {
      (my $key) = $scales[$i]->name=~/.* ([^ ]+)$/;
      printf(JSONFILE ",\n") if $hadscale;
      printf(JSONFILE ' ' x $indent . "{ \"root\": \"%s\", \"notes\": [", $key);
      my @bn;
      @bn = (-1) x 15;
      foreach my $n (@{$scales[$i]->notes}) {
        my $midi;
        my $color;
        ($midi, $color) = split(/;/, $n);
        $bn[$color - 1] = $midi % 12;
      }
      my $hadnote = 0;
      my $rootnote = -1;
      for (my $r = 0; $r < 12; $r++) {
        if ($bn[$r] >= 0) {
          printf(JSONFILE ", ") if $hadnote;
          printf(JSONFILE "\"%s\"", $notes[$bn[$r]]);
          $hadnote = 1;
          if ($rootnote < 0) {
            $rootnote = $r;
          }
        }
      }
      $indent += $indentwidth;
      printf(JSONFILE "],\n");
      if ($notes[$bn[$rootnote]] ne $key && $altnotes[$bn[$rootnote]] ne $key) {
        printf(JSONFILE ' ' x $indent . "  \"_warning\": \"root note mismatch\",\n");
      }
      printf(JSONFILE ' ' x $indent . "\"chords\": [\n");
      $indent += $indentwidth;
      printf(JSONFILE ' ' x $indent);
      my $hadchord = 0;
      my $wrap = 6;
      for my $c (@{$scales[$i]->chords}) {
        printf(JSONFILE ", ") if $hadchord;
        if ($wrap <= 0) {
          printf(JSONFILE "\n" . ' ' x $indent);
          $wrap = 6;
        }
        $wrap--;
        my $index;
        my $color;
        ($index, $color) = split(/;/, $c);
        printf(JSONFILE "%-12s", '"' . $chords[$index]->name . '"');
        $hadchord = 1;
      }

      $indent -= $indentwidth;
      printf(JSONFILE "\n" . ' ' x $indent . "]");
      $indent -= $indentwidth;
      printf(JSONFILE "\n" . ' ' x $indent . "}");
      $hadscale = 1;
  }
  $hadgroup = 1;
  $indent -= $indentwidth;
  printf(JSONFILE ' ' x $indent . "]\n");
  $indent -= $indentwidth;
  printf(JSONFILE ' ' x $indent . "}");
}
$indent -= $indentwidth;
printf(JSONFILE "\n" . ' ' x $indent . "],\n");

# Finally, scale categories
printf(JSONFILE ' ' x $indent . "\"Categories\" : [\n");
$indent += $indentwidth;

$indent -= $indentwidth;
printf(JSONFILE "\n" . ' ' x $indent . "]\n");

printf(JSONFILE "}\n");

# ------------ Subroutines -------------------------
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

sub unifiedname {
  my $uname;
  my $n;
  $uname = $_[0];
  for ($n = 0; $n < @altnotes; $n++) {
    if ($altnotes[$n] ne 'nil') {
      $uname =~ s/\Q$altnotes[$n]\E/$notes[$n]/g; 
    }
  }
  return $uname;
}