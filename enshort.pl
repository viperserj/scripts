#!/usr/bin/perl -ls
#	Enshort - i.unix.ga URL shortener CLI client.
#	v.1.0
#	Author - viperserj (sj@404.pm)
use LWP;
my $url = shift;
my $browser = LWP::UserAgent->new();
$browser->post('http://i.unix.ga/cc', {'url'=>$url})->as_string =~ /http:\/\/i\.unix\.ga\/[a-z0-9]{6}/si;
if (not defined $&) {die "Link can't be processed\n";}
print "\n$&\n";
exit 0;
