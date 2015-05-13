#!/usr/bin/perl -pls
#Forecaster - граббер погоды с pogoda.yandex.ru
#Версия 0.1.3 alpha
#Changelog:
#0.1 - initial release
#0.1.1 - Minor fixes :D
#0.1.2 - Added wind, humidity, sunser and sunrise time, minor interface corrections
#0.1.3 - Added forecast for nine more days, some formatting, fixed minor bugs
#To-do: ввод города БЕЗ режима прямого ввода (forecast Saratov, к примеру); переключение ключей параметров вывода информации (к релизу 0.2a).
system "curl -silent https://pogoda.yandex.ru/$_ -o \"tmp\"";
$title = `egrep -o 'title_level_1">.*<\/h1>' ./tmp | cut -c16- | cut -d '<' -f 1`;
$current = `egrep -o '_thermometer_type_now">.[0-9]*&thinsp;°C<\/div>' ./tmp | cut -c24- | cut -d '&' -f 1`;
$after = `egrep -o '_thermometer_type_after">.[0-9]*<\/div>' ./tmp | cut -c26- | cut -d '<' -f 1`;
$comment = `egrep -o 'current-weather__comment">.[- абвгдеёжзиЙклмнопрстуфхцчшщЪыьэюя]*<\/span>' ./tmp | cut -c27- | cut -d '<' -f 1`;
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
$forecast_day = `egrep -o 'item-dayname">[а-я]+' ./tmp | cut -c15-`;
$forecast_day_t = `egrep -o 'Максимальная температура днём">.?[0-9]+[ а-я]*<\/div>' ./tmp | cut -c59- | cut -d '<' -f 1`;
$forecast_day_t =~ s/ днем//gi;
$forecast_day_t =~ s/\n/°C\t/gi;
$forecast_day =~ s/\n/\t/gi;
$forecast_night_t = `egrep -o 'Минимальная температура ночью">.?[0-9]+[ а-я]*<\/div>' ./tmp | cut -c59- | cut -d '<' -f 1`;
$forecast_night_t =~ s/ ночью//gi;
$forecast_night_t =~ s/\n/°C\t/gi;
$title =~ s/\n//gi;
$current =~ s/\n/°C/i;
$comment =~ s/\n//i;
$after =~ s/\n/°C\t/i;
$after =~ s/\n/°C/i;
print "$title\nСейчас \t\t$current, $comment\nВлажность: \t$humidity\nДавление: \t$pressure";
print "Восход: \t$sunrise\nЗакат: \t\t$sunset\nВетер: \t\t$wind_s, $wind_d";
print "\nБлижайший прогноз\n+0ч\t+6ч\t+12ч\n$current\t$after";
print "\nПрогноз на следующие 9 дней";
print "Время\t$forecast_day";
print "День\t$forecast_day_t";
print "Ночь\t$forecast_night_t";
exit 0;
