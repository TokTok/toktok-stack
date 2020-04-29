#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';

my ($GITMODULES, $GITREMOTES, @PROJECTS) = @ARGV;

sub parse_gitmodules {
   my ($file) = @_;

   my %mods;
   my $cur;

   open my $fh, '<', $file or die "$file: $!";
   while (<$fh>) {
      if (m|^\[submodule "(.*)"\]$|) {
         $cur = $mods{$1} = {};
      } elsif (m|^\tpath = (.*)|) {
         $cur->{path} = $1;
      } elsif (m|^\turl = https://github.com/TokTok/(.*)|) {
         $cur->{repo} = $1;
      }
   }

   my %repos = map { $mods{$_}{path} => $mods{$_}{repo} } keys %mods;
   \%repos;
}

sub parse_gitremotes {
   package GitRemotes;
   use File::Basename;

   do "./$GITREMOTES";

   my %repos;

   sub is_subsubmodule {
      my ($dir) = @_;
      while ($dir ne '.' and $dir ne '/') {
         $dir = dirname $dir;
         return 1 if $GitRemotes::REPOS{$dir};
      }
      0
   }

   for my $path (keys %GitRemotes::REPOS) {
      # Filter out submodules of submodules. They do appear in git-remotes, but
      # not in .gitmodules, because they appear in the submodule's .gitmodules,
      # which we're not testing.
      next if is_subsubmodule $path;
      $repos{$path} = $GitRemotes::REPOS{$path}[0];
   }

   \%repos
}

my $modules = parse_gitmodules $GITMODULES;
my $remotes = parse_gitremotes $GITREMOTES;
my %projects = map { $_ => undef } @PROJECTS;

# Check that .gitmodules doesn't have more modules than git-remotes.
for my $repo (sort keys %$modules) {
   die ".gitmodules contains submodule '$repo' not listed in %REPOS in $GITREMOTES\n"
      unless exists $remotes->{$repo};
}
# And vice-versa.
for my $repo (sort keys %$remotes) {
   die "$GITREMOTES contains repository '$repo' not listed in .gitmodules\n"
      unless exists $modules->{$repo};
}
# Check that tools/BUILD.bazel knows about all our projects.
for my $repo (sort keys %$modules) {
   die ".gitmodules contains submodule '$repo' not listed in projects in tools/BUILD.bazel\n"
      unless exists $projects{$repo};
}
# And it doesn't have too many.
for my $repo (sort @PROJECTS) {
   die "tools/BUILD.bazel lists project '$repo' that isn't listed in .gitmodules"
      unless exists $modules->{$repo};
}
