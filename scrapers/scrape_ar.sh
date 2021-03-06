#!/bin/sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"  # " # To make editor happy


echo AR
d=$("${DIR}/download.sh" "https://www.ar.ch/verwaltung/departement-gesundheit-und-soziales/amt-fuer-gesundheit/informationsseite-coronavirus/" | egrep "Aktuelle Informationen: Zahlen")
echo "Scraped at: $(date --iso-8601=seconds)"


# <div id="c61590" class="csc-element  accordeon-element" ><h2 class="header header2 header-default ">Aktuelle Informationen: Zahlen </h2><div class="csc-textpic-text"><p class="bodytext">&nbsp;</p>
# <p class="bodytext">Appenzell Ausserrhoden hat (Stand 23. März 2020, 10.00 Uhr)<strong> </strong></p><ul><li>30 bestätigte Fälle</li> 	<li>7 Personen hospitalisiert, davon 2 Personen noch nicht bestätigt</li> 	<li>1 Person verstorben</li></ul><p class="bodytext"><strong>Hinweis</strong>: Die Fallzahlen zeigen nicht die Anzahl Ansteckungen mit dem Coronavirus, sondern die Anzahl Erkrankungen mit COVID-19. Es dauert bei den meisten Menschen etwa 7 Tage, bis sie nach der Ansteckung mit dem Coronavirus Symptome haben. Nur wenn sich alle Leute an die Regeln halten, kann die&nbsp;Verbreitung gestoppt werden. Die Lage ist ernst. Appenzell Ausserrhoden tut alles, damit die Bevölkerung versorgt werden kann.</p></div></div>

# <p class="bodytext">Appenzell Ausserrhoden hat&nbsp;mit&nbsp; Stand 24.3. / 10h:<strong>


echo -n "Date and time: "
echo "$d" | egrep "F.lle.*Stand" | tail -1 | sed -E -e 's/^.*Stand\: (.+ Uhr)\)<.+$/\1/' -e 's/^.*Stand ([0-9]+\.[0-9]+\.? \/ [0-9]+h).*$/\1/'

echo -n "Confirmed cases: "
echo "$d" | egrep ".*bestätigte Fälle:" | sed -E -e 's/.*bestätigte Fälle:( |&nbsp;)*<strong>([0-9]+)[^<]*<\/strong>.*$/\2/'

echo -n "Deaths: "
echo "$d" | egrep ".*Todesfälle:" | sed -E -e 's/.*Todesfälle:( |&nbsp;)*<strong>([0-9]+)[^<]*<\/strong>.*$/\2/'
