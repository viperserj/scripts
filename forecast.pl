#!/usr/bin/perl -pls
#Forecaster - граббер погоды с pogoda.yandex.ru
#Версия 0.1.2 alpha
#Changelog:
#0.1 - initial release
#0.1.1 - Minor fixes :D
#0.1.2 - Added wind, humidity, sunser and sunrise time, minor interface corrections
#To-do: скорость и направление ветра (возможно со стрелочками =3); прогноз погоды на несколько дней; ввод города БЕЗ режима прямого ввода (forecast Saratov, к примеру).
system "curl -silent https://pogoda.yandex.ru/$_ -o \"tmp\"";
$title = `egrep -o 'title_level_1">.*<\/h1>' ./tmp | cut -c16- | cut -d '<' -f 1`;
$current = `egrep -o '_thermometer_type_now">.[0-9]*&thinsp;°C<\/div>' ./tmp | cut -c24- | cut -d '&' -f 1`;
$after = `egrep -o '_thermometer_type_after">.[0-9]*<\/div>' ./tmp | cut -c26- | cut -d '<' -f 1`;
$comment = `egrep -o 'current-weather__comment">.[а-яА-Я]*<\/span>' ./tmp | cut -c27- | cut -d '<' -f 1`;
$wind_d = `egrep -o 'title="Ветер:.*' ./tmp | cut -c20- | cut -d '"' -f 1`;
$wind_s = `egrep -o 'Ветер: <\/span> [0-9]+,[0-9] м\/с' ./tmp | cut -c21-`;
$wind_d =~ s/\n//gi;
$wind_s =~ s/\n//gi;
$pressure = `egrep -o 'n>[0-9]* мм рт. ст.' ./tmp | cut -c3-`;
$pressure =~ s/\n//gi;
$humidity = `egrep -o 'n>[0-9]*%' ./tmp | cut -c3-`;
$humidity =~ s/\n//gi;
$sunrise = `egrep -o 'д: <\/span>[0-9][0-9]:[0-9][0-9]' ./tmp | cut -c12-`;
$sunset = `egrep -o 'т: <\/span>[0-9][0-9]:[0-9][0-9]' ./tmp | cut -c12-`;
$sunrise =~ s/\n//gi;
$sunset =~ s/\n//gi;
#$forecast_day = ``;
#$forecast_day_t = ``;
#$forecast_night_t = ``;
#$forecast_comment = ``;
$title =~ s/\n//gi;
$current =~ s/\n/°C/i;
$comment =~ s/\n//i;
$after =~ s/\n/°C → /i;
$after =~ s/\n/°C/i;
print "$title\nСейчас $current, $comment\nВлажность: $humidity\nДавление: $pressure";
print "Восход: $sunrise\nЗакат: $sunset\nВетер: $wind_s, $wind_d";
print "Ближайший прогноз (+0ч → +6ч → +12ч): $current → $after";

exit 0;
