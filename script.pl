#!/usr/bin/perl -pl
system "curl $_ | egrep -o '<title>.*<\/title>' | cut -c8- | cut -d '<' -f 1";
