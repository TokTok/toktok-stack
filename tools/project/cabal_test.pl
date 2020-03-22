#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use utf8;

sub slurp {
   local $/;
   open my $fh, '<', $_[0] or die "'$_[0]': $!";
   <$fh>
}

my ($build_file, $cabal_file) = @ARGV;
my $build = slurp $build_file;
my $cabal = slurp $cabal_file;

# Check package name consistency.
my ($cabal_name) = $cabal =~ m/^name:\s+([a-zA-Z0-9_-]+)\n/
   or die "name field must be defined in '$cabal_file'\n";
my ($build_name) = $build =~ m/haskell_library\(\n    name = "hs-([a-zA-Z0-9_-]+)",\n/
   or die "a haskell_library starting with 'hs-' must be defined in '$build_file'\n";

die "$cabal_file ($cabal_name) and $build_file ($build_name) disagree on package name\n"
   if $cabal_name ne $build_name;

# Check test target name.
my ($test_name) = $build =~ m/hspec_test\(\n    name = "([a-zA-Z0-9_-]+)",\n/
   or die "a hspec_test must be defined in '$build_file'\n";

die "hspec_test should be named 'testsuite' but is '$test_name'\n"
   if $test_name ne "testsuite";

# Check version consistency.
my ($cabal_version) = $cabal =~ m/\nversion:\s+([0-9.]+)\n/
   or die "version field must be defined in '$cabal_file'\n";
my ($build_version) = $build =~ m/\n    version = "([0-9.]+)",\n/;
($build_version) = $build =~ m/\nVERSION = "([0-9.]+)"\n/
   unless $build_version;
$build_version or die "version field must be defined in '$build_file'\n";

die "$cabal_file ($cabal_version) and $build_file ($build_version) disagree on package version\n"
   if $cabal_version ne $build_version;

# Build dependencies consistency.
sub compare_deps {
   my ($cabal_decl, $build_decl) = @_;

   my ($cabal_library_depends) = $cabal =~ m/\n$cabal_decl\n(?:.|\n)*?  build-depends:\s*([^:]+)\n(?:\n|$)/
      or die "$cabal_decl.build-depends field must be defined in '$cabal_file'\n";
   my @cabal_library_depends = split /\s*,\s*/, $cabal_library_depends;
   s/ .*// for @cabal_library_depends;
   @cabal_library_depends = sort @cabal_library_depends;

#   print "$cabal_decl: $_\n" for @cabal_library_depends;

   my ($build_library_depends) = $build =~ m/\n$build_decl\(\n(?:.|\n)*?    deps = \[\n*\s*([^\]]+)\]/
      or die "$build_decl.deps must be defined in '$build_file'\n";
   my @build_library_depends = grep { not m/"\/\/c-/ } split /\s*,\s*/, $build_library_depends;
   s/"(?::|\/\/)hs-(.*)"/$1/g for @build_library_depends;
   s/hazel_library\("(.*)"\)/$1/g for @build_library_depends;
   @build_library_depends = sort @build_library_depends;

#   print "$build_decl $_\n" for @build_library_depends;

   my %in_both;
   for my $build_dep (@build_library_depends) {
      $in_both{$build_dep} = 1 if grep { $_ eq $build_dep } @cabal_library_depends;
   }
#   print "both $_\n" for sort keys %in_both;

   @cabal_library_depends = grep { not $in_both{$_} } @cabal_library_depends;
   @build_library_depends = grep { not $in_both{$_} } @build_library_depends;
   die "$cabal_decl.build-depends in $cabal_file not present in $build_decl.deps in $build_file: @cabal_library_depends\n"
      if @cabal_library_depends;
   die "$build_decl.deps in $build_file not present in $cabal_decl.build-depends in $cabal_file: @build_library_depends\n"
      if @build_library_depends;
}

compare_deps "library", "haskell_library";
compare_deps "test-suite testsuite", "hspec_test";
