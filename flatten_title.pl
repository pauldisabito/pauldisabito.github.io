#!/usr/bin/perl

use strict;
use warnings;

my @files = glob("docs/**/*.html");

foreach my $file (@files) {
  open(my $fh, '<', $file) or die "Could not open file '$file': $!";
  my $contents = do { local $/; <$fh> };
  close($fh);

  $contents =~ s/<title>\s*(.*?)\s*<\/title>/<title>$1<\/title>/gs;

  open($fh, '>', $file) or die "Could not open file '$file': $!";
  print $fh $contents;
  close($fh);
}
