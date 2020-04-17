'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "17c2fcb0f84c471fe2c927bed2c859d8",
"assets/assets/images/basketball.png": "8055b697296385573ac53b1a12922da0",
"assets/assets/images/google_logo.png": "b75aecaf9e70a9b1760497e33bcd6db1",
"assets/FontManifest.json": "0621fb7723859a382fc19210904f6578",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "395fdba9d0246a6e855417b752111b1c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "fe1545ef4dd1eef2f1e25528898fc0b3",
"favicon-16x16.png": "5b2d89811dbdde45780850863d4d913e",
"favicon.ico": "e90e558b28216bbfb20b734fe6b05fea",
"icons/android-chrome-192x192.png": "105071af0f043eddd6359069f265b005",
"icons/android-chrome-512x512.png": "6afade3662b1e346b6d46594f8761b8e",
"icons/apple-touch-icon.png": "9e9199ec9d9b60282c33224926f1ade4",
"icons/favicon-32x32.png": "16e360dc930c64da4abe854882318342",
"index.html": "af97798b0b111488ce1dc59ca507254c",
"/": "af97798b0b111488ce1dc59ca507254c",
"main.dart.js": "da7169532de1e045b4a0d4ba3c1c2da5",
"main.dart.js_1.part.js": "d39b3730f8ae5b64383853611643f489",
"main.dart.js_1.part.js.map": "cc4c6ab897f268986b4ca99647749c9f",
"manifest.json": "44296ca56dc3b66a7deecbf7a30f2b30"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
