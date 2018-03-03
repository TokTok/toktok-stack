#!/bin/sh

BZIP2=$1

set -eux

$BZIP2 -1  < external/bzip2/sample1.ref > $TEST_TMPDIR/sample1.rb2
$BZIP2 -2  < external/bzip2/sample2.ref > $TEST_TMPDIR/sample2.rb2
$BZIP2 -3  < external/bzip2/sample3.ref > $TEST_TMPDIR/sample3.rb2
$BZIP2 -d  < external/bzip2/sample1.bz2 > $TEST_TMPDIR/sample1.tst
$BZIP2 -d  < external/bzip2/sample2.bz2 > $TEST_TMPDIR/sample2.tst
$BZIP2 -ds < external/bzip2/sample3.bz2 > $TEST_TMPDIR/sample3.tst
cmp external/bzip2/sample1.bz2 $TEST_TMPDIR/sample1.rb2 
cmp external/bzip2/sample2.bz2 $TEST_TMPDIR/sample2.rb2
cmp external/bzip2/sample3.bz2 $TEST_TMPDIR/sample3.rb2
cmp $TEST_TMPDIR/sample1.tst external/bzip2/sample1.ref
cmp $TEST_TMPDIR/sample2.tst external/bzip2/sample2.ref
cmp $TEST_TMPDIR/sample3.tst external/bzip2/sample3.ref
