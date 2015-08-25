#!/usr/bin/perl -ls
#	News - last news fetcher from lenta.ru
#	Author - viperserj (sj@404.pm)
#
#	Version 0.1.0
#
#	Changelog:
#	0.1.0 - Initial release.
#
#	To-Do: dunno, lol.
use strict;

#	Input
system "curl -silent -L http://m.lenta.ru/ -o \"news\"";
my @links;	my @news;	my @times;
for (my $i=1;$i<=7;$i++) {
	$links[$i] = `egrep -o 'b-list-item__link" href=.*"' ./news | head -n $i | tail -n 1 | cut -d '=' -f 2 | cut -d '"' -f 2 | sed 's/^/m.lenta.ru/gi'`;
	$times[$i] = `egrep -o 'datetime="[ ,:0-9а-я]*"' ./news | head -n $i | tail -n 1 | cut -d '"' -f 2`;
	$news[$i] = `egrep -o 'b-list-item__title">.*</span>' ./news | head -n $i | tail -n 1 | cut -d '>' -f 2 | cut -d '<' -f 1`;
	$links[$i] =~ s/\n//;
	$news[$i] =~ s/^/$times[$i]/;
	$news[$i] =~ s/$/\nhttp:\/\/$links[$i]/;
	$news[$i] =~ s/^/#$i --/;
	print $news[$i];
}
exit 0;
