#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Crawler' ) || print "Bail out!\n";
}

diag( "Testing Crawler $Crawler::VERSION, Perl $], $^X" );
