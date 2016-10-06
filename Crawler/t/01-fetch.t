#!perl -T
use 5.0020;
use strict;
use warnings;
use Test::More;
use Data::Dumper;
use URI;

BEGIN {
    use_ok( 'Crawler' ) || print "Bail out!\n";
}

diag( "Testing Crawler $Crawler::VERSION, Perl $], $^X" );

my $crawler=Crawler->new();
my $uri = URI->new("http://www.exonetric.com");
$crawler->scope($uri);

ok(defined $crawler, "got something for crawler");

my $html = $crawler->fetch_html($uri);
diag("html was $html\n");
ok(defined $html, "got something for html");

my ($digest,$links,$assets) = $crawler->get_links($uri);
diag("digest looks like $digest\n");
diag("links looks like\n".Dumper($links));
diag("assets looks like\n".Dumper($assets));
ok(defined $links->[0], "got something from parser for links");


$crawler->crawl();
diag("sitemap looks like:", Dumper($crawler->sitemap()));
done_testing;
