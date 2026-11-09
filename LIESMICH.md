# Capo Shift

Liedblatt (Foto oder PDF) laden, Capo wählen, neues PDF mit den passenden Griffen exportieren. Läuft komplett im Browser, ohne Konto und ohne externe Dienste. Nach dem ersten Öffnen auch offline.

## Auf dem iPhone installieren

App-Adresse in Safari öffnen, Teilen > „Zum Home-Bildschirm".

## Wie die Seite entsteht

Bei jedem Push auf `main` baut der Workflow `.github/workflows/deploy.yml` mit `build.sh` den Ordner `site`: die App-Dateien aus diesem Repo plus Bibliotheken, Schriften und Erkennungsdaten in festen Versionen aus der npm-Registry. Das Ergebnis geht auf GitHub Pages. Zur Laufzeit lädt die App nichts von fremden Servern.

## Updates

Nach Änderungen in `sw.js` die Zeile `const VERSION='capo-shift-v1'` hochzählen, sonst behalten installierte Apps die alte Version im Cache.

## Enthaltene Bibliotheken

jsPDF 2.5.1 (MIT), pdf.js 3.11.174 (Apache 2.0), Tesseract.js und tesseract.js-core 5.1.1 (Apache 2.0), deutsche Erkennungsdaten tessdata best_int (Apache 2.0), Schriften Bricolage Grotesque, IBM Plex Sans, IBM Plex Mono (SIL OFL 1.1).
