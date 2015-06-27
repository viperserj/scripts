#!/usr/bin/perl -ls
#	Погода 1.0 - погодный скрипт, основанный на Pogoda,Yandex API
use strict;
use LWP::Simple;
use XML::XPath;
use utf8;
use Encode;

binmode(STDOUT,':utf8');
#	Ввод и получение данных
my $city = shift;
if (not defined $city) {die "Использование: $0 <город>\n";}
my $city = decode ('utf8', $city);
my $cities = get('https://pogoda.yandex.ru/static/cities.xml') or die "404 - Невозможно получить список городов!\n";
my $xp = XML::XPath->new(xml => $cities);
my $id = $xp->find("/cities/country/city[text()='$city']/\@id");
$city = get("http://export.yandex.ru/weather-ng/forecasts/$id.xml");
$xp = XML::XPath->new(xml => $city);
my $wd = $xp->find('//fact/wind_direction/text()'); $wd =~ tr/nswe/СЮЗВ/;
#	Вывод погоды
print $xp->find('/*/@city'),', ',$xp->find('/*/@country'),"\n";
print "Сейчас:\t\t",$xp->find('//fact/temperature/text()'),'°C, ',$xp->find('//fact/weather_type_short/text()');
print "Ветер:\t\t",$xp->find('//fact/wind_speed/text()'),"мс, $wd";
print "Давление:\t",$xp->find('//fact/pressure/text()'),' мм рт.ст.';
exit 0;


