#!/usr/bin/perl -ls
#Stinky - поиск и удаление старых и больших файлов.
#Author - viperserj (sj@404.pm)
#
#Версия 0.1
#
#Changelog:
#0.1	-	initial release.
#
#To-Do: задание возраста и размера файлов в параметрах, стандартно - старше 30-ти дней и больше 100 мегабайт
$par = shift;
#if (defined $par) {$par = $par + 'c';}
if (not defined $par) {$par = "104857600c";}
system "find /home/* -mtime +1 -size +$par | grep -v find: | sort";
exit 0;
