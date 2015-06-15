#!/usr/bin/perl -ls
# Forecaster - граббер погоды с pogoda.yandex.ru
# Author - viperserj (sj@404.pm)
#
# Версия 0.1.7
#
# Changelog:
# 0.1 	- initial release.
# 0.1.1	- Minor fixes.
# 0.1.2	- Added wind, humidity, sunser and sunrise time, minor interface corrections.
# 0.1.3	- Added forecast for nine more days, some formatting, fixed minor bugs.
# 0.1.4	- Added $0 <city> form, minor issues fixing.
# 0.1.5	- Fixed bug with 0m/s windspeed.
# 0.1.6	- Added russian input, minor issues fixed.
# 0.1.7	- Minor fixes, readability improved.
#
# To-do: переключение ключей параметров вывода информации (к релизу 0.2a)

# Секция ввода
$city = shift;
if (not defined $city) {die "Usage: $0 <city_name>\n";}

system "curl -silent -L https://pogoda.yandex.ru/$city -o \"tmp\"";

# Секция парсинга данных
$title = `egrep -o 'title_level_1">.*<\/h1>' ./tmp | cut -c16- | cut -d '<' -f 1`;
if ($title eq "Такой страницы не существует\n") {die "Города нет в базе данных\n";}
$current = `egrep -o '_thermometer_type_now">.[0-9]+' ./tmp | cut -c24-`;
$after = `egrep -o '_thermometer_type_after">.[0-9]+' ./tmp | cut -c26-`;
$comment = `egrep -o 'current-weather__comment">[- абвгдеёжзиЙклмнопрстуфхцчшщЪыьэюя,]+' ./tmp | cut -c27-`;
$wind_d = `egrep -o 'title="Ветер:.*' ./tmp | cut -c20- | cut -d '"' -f 1`;
$wind_s = `egrep -o 'Ветер: <\/span>(Штиль| [0-9]+,[0-9] м\/с)' ./tmp | cut -c20-`;
$pressure = `egrep -o 'n>[0-9]* мм рт. ст.' ./tmp | cut -c3-`;
$humidity = `egrep -o 'n>[0-9]*%' ./tmp | cut -c3-`;
$sunrise = `egrep -o 'д: <\/span>[0-9][0-9]:[0-9][0-9]' ./tmp | cut -c12-`;
$sunset = `egrep -o 'т: <\/span>[0-9][0-9]:[0-9][0-9]' ./tmp | cut -c12-`;
$forecast_day = `egrep -o 'item-dayname">[а-я]+' ./tmp | cut -c15-`;
$forecast_day_t = `egrep -o 'Максимальная температура днём">.?[0-9]+[ а-я]*<\/div>' ./tmp | cut -c59- | cut -d '<' -f 1`;
$forecast_night_t = `egrep -o 'Минимальная температура ночью">.?[0-9]+[ а-я]*<\/div>' ./tmp | cut -c59- | cut -d '<' -f 1`;
$tomorrow_state= `egrep -o 'item-comment">[- а-я,ё]+' ./tmp | cut -c15`;

if ($wind_s eq "Штиль") { $wind_s='0 м/с'; $wind_d='штиль'; }

# Секция обработки данных
$city=~s/ /-/gi;
$pressure =~ s/\n//gi;
$humidity =~ s/\n//gi;
$sunrise =~ s/\n//gi;
$sunset =~ s/\n//gi;
$wind_d =~ s/\n//gi;
$wind_s =~ s/\n//gi;
$wind_s =~ s/ //i;
$tomorrow_state=~s/\n//gi;
$title =~ s/\n//gi;
$current =~ s/\n/°C/i;
$comment =~ s/\n//i;
$after =~ s/\n/°C\t/i;
$after =~ s/\n/°C/i;
$forecast_day =~ s/\n/\t/gi;
$forecast_day_t =~ s/ днем//gi;
$forecast_day_t =~ s/\n/°C\t/gi;
$forecast_night_t =~ s/ ночью//gi;
$forecast_night_t =~ s/\n/°C\t/gi;

# Секция вывода
print "$title\nСейчас \t\t$current, $comment\nВлажность: \t$humidity\nДавление: \t$pressure";
print "Восход: \t$sunrise\nЗакат: \t\t$sunset\nВетер: \t\t$wind_s, $wind_d";
print "\nБлижайший прогноз\n+0ч\t+6ч\t+12ч\n$current\t$after";
print "\nПрогноз на следующие 9 дней";
print "Время\t$forecast_day";
print "День\t$forecast_day_t";
print "Ночь\t$forecast_night_t";

exit 0;
