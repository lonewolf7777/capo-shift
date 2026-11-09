// Capo Shift Offline-Cache. Bei Änderungen an der App VERSION erhöhen.
const VERSION='capo-shift-v1';
const FILES=[
  "./",
  "apple-touch-icon.png",
  "bricolage-grotesque-latin-500-normal.woff2",
  "bricolage-grotesque-latin-700-normal.woff2",
  "deu.traineddata.gz",
  "favicon.png",
  "ibm-plex-mono-latin-400-normal.woff2",
  "ibm-plex-mono-latin-600-normal.woff2",
  "ibm-plex-sans-latin-400-normal.woff2",
  "ibm-plex-sans-latin-500-normal.woff2",
  "ibm-plex-sans-latin-600-normal.woff2",
  "icon-192.png",
  "icon-512.png",
  "icon-maskable-512.png",
  "index.html",
  "jspdf.umd.min.js",
  "manifest.webmanifest",
  "pdf.min.js",
  "pdf.worker.min.js",
  "tesseract-core-lstm.wasm.js",
  "tesseract-core-simd-lstm.wasm.js",
  "tesseract-worker.min.js",
  "tesseract.min.js",
];
self.addEventListener('install',e=>{e.waitUntil(caches.open(VERSION).then(c=>c.addAll(FILES)).then(()=>self.skipWaiting()));});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(ks=>Promise.all(ks.filter(k=>k!==VERSION).map(k=>caches.delete(k)))).then(()=>self.clients.claim()));});
self.addEventListener('fetch',e=>{
  if(e.request.method!=='GET') return;
  const url=new URL(e.request.url); if(url.origin!==location.origin) return;
  e.respondWith(caches.match(e.request,{ignoreSearch:true}).then(hit=>hit||fetch(e.request).then(res=>{
    if(res.ok){const copy=res.clone(); caches.open(VERSION).then(c=>c.put(e.request,copy));}
    return res;
  })));
});
