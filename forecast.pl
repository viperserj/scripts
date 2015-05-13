#!/usr/bin/perl -pls
#Forecaster - граббер погоды с pogoda.yandex.ru
#Версия 0.1 alpha
#To-do: скорость и направление ветра (возможно со стрелочками =3); прогноз погоды на несколько дней; ввод города БЕЗ режима прямого ввода (forecast Saratov, к примеру).
system "curl -silent https://pogoda.yandex.ru/$_ -o \"tmp\"";
$title = `egrep -o 'title_level_1">.*<\/h1>' ./tmp | cut -c1-16 | cut -d '<' -f 1`;
$current = `egrep -o '_thermometer_type_now">.[0-9]*&thinsp;°C<\/div>' ./tmp | cut -c24- | cut -d '&' -f 1`;
$after = `egrep -o '_thermometer_type_after">.[0-9]*<\/div>' ./tmp | cut -c26- | cut -d '<' -f 1`;

$comment = `egrep -o 'current-weather__comment">.[а-яА-Я]*<\/span>' ./tmp | cut -c27- | cut -d '<' -f 1`;
$title =~ s/\n//gi;
$current =~ s/\n/°C/i;
$comment =~ s/\n//i;
$after =~ s/\n/°C → /i;
$after =~ s/\n/°C/i;
print "$title\nСейчас $current, $comment";
print "Ближайший прогноз: $current → $after";
exit 0;
