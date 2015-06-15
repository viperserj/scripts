#!/usr/bin/perl -ls
$_=shift;
if (not defined $_) {die "Add link";}
if ($_=~/youtu\.?be\.?.*\//)
{my $title = `curl -silent -L $_ | egrep -o '>.*<\/tit' | cut -c2- | cut -d '<' -f 1`;
my $user = `curl -silent -L $_ | egrep -o '\"\/user\/.*\"' | cut -c8- | cut  -d '\"' -f 1`;
$user =~ s/\n//gi;
print "test\n";
print "$user - $title";}
#elseif {$_=~/(i.)?imgur\.com }
else {print "failed";}
