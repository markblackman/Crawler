#!/usr/bin/env perl

use strict;
use warnings;

use lib "Crawler/lib";

use URI;
use URI::Split qw(uri_split uri_join);
use Crawler;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($DEBUG);

my $man  = 0;
my $help = 0;
my $dot  = 0;
## Parse options and print usage if there is a syntax error,
## or if usage was explicitly requested.

GetOptions(
  'help|?' => \$help,
  man      => \$man,
  dot      => \$dot
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-verbose => 2) if $man;

## print usage if no arguments
pod2usage("$0: No URI given.") if (@ARGV == 0);

my $uri = $ARGV[0];

my $crawler = Crawler->new();

my ($scheme, $auth, $path, $query, $frag) = uri_split($uri);

my $fqdn_uri = URI->new($uri);

if (!$fqdn_uri->authority) {
  $fqdn_uri->authority($path);
  $fqdn_uri->path('');
  $fqdn_uri->scheme('http');
}

INFO "crawling " . $fqdn_uri->canonical . "\n";

$crawler->scope($fqdn_uri);
$crawler->crawl();
$crawler->display_site_map(dot => $dot);

__END__

=head1 NAME

crawl.pl - crawl a site and output a site map.

=head1 SYNOPSIS

crawl.pl [options] [http://]sample.com

 Options:
   -help            brief help message
   -man             full documentation
   -dot             output sitemap as dot format, suitable for graphviz.

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> given a URL, should output a site map, showing which static
assets each page depends on, and the links between pages.

=cut
