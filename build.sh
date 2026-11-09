#!/usr/bin/env bash
# Baut den fertigen Seitenordner "site": App-Dateien + Bibliotheken, Schriften und Erkennungsdaten aus der npm-Registry (feste Versionen).
set -euo pipefail
V=$(mktemp -d)
npm install --prefix "$V" --no-save --no-audit --no-fund --omit=optional \
  jspdf@2.5.1 pdfjs-dist@3.11.174 tesseract.js@5.1.1 tesseract.js-core@5.1.1 \
  @tesseract.js-data/deu@1.0.0 @fontsource/bricolage-grotesque@5.3.0 \
  @fontsource/ibm-plex-sans@5.3.0 @fontsource/ibm-plex-mono@5.3.0 >/dev/null
N="$V/node_modules"
rm -rf site && mkdir site
cp index.html sw.js manifest.webmanifest site/
python3 -m pip install --quiet --disable-pip-version-check pillow >/dev/null 2>&1 || python3 -m pip install --quiet --break-system-packages pillow
python3 make_icons.py
cp "$N/jspdf/dist/jspdf.umd.min.js" "$N/pdfjs-dist/build/pdf.min.js" "$N/pdfjs-dist/build/pdf.worker.min.js" site/
cp "$N/tesseract.js/dist/tesseract.min.js" site/
cp "$N/tesseract.js/dist/worker.min.js" site/tesseract-worker.min.js
cp "$N/tesseract.js-core/tesseract-core-lstm.wasm.js" "$N/tesseract.js-core/tesseract-core-simd-lstm.wasm.js" site/
cp "$N/@tesseract.js-data/deu/4.0.0_best_int/deu.traineddata.gz" site/
for f in bricolage-grotesque/files/bricolage-grotesque-latin-500-normal bricolage-grotesque/files/bricolage-grotesque-latin-700-normal \
         ibm-plex-sans/files/ibm-plex-sans-latin-400-normal ibm-plex-sans/files/ibm-plex-sans-latin-500-normal ibm-plex-sans/files/ibm-plex-sans-latin-600-normal \
         ibm-plex-mono/files/ibm-plex-mono-latin-400-normal ibm-plex-mono/files/ibm-plex-mono-latin-600-normal; do
  cp "$N/@fontsource/$f.woff2" site/
done
touch site/.nojekyll
# Prüfen, dass jede im Offline-Cache gelistete Datei existiert
for f in $(grep -o '"[^"]*"' sw.js | tr -d '"' | grep -v '^\./$' | grep '\.'); do test -f "site/$f" || { echo "fehlt: $f"; exit 1; }; done
echo "Fertig: $(ls site | wc -l) Dateien"
