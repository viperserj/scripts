#!/usr/bin/perl -pl
my $title = `curl --silent $_ | egrep -o '<title>.*<\/title>' | cut -c8- | cut -d '<' -f 1`;
my $user = `curl --silent $_ | egrep -o '\"\/user\/.*\"' | cut -c8- | cut  -d '\"' -f 1`;
print "$user$title";
