'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.ico": "e90e558b28216bbfb20b734fe6b05fea",
"main.dart.js": "8f6dd2d7506004ea7e527150543bb5ef",
"main.dart.js_1.part.js": "3f07f10a00050de7db45838a0a951f20",
"main.dart.js_1.part.js.map": "72cb716d15f2c476b9a66473c37048be",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "0621fb7723859a382fc19210904f6578",
"assets/LICENSE": "145a7156022925f73584dc242354a1ad",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "fe1545ef4dd1eef2f1e25528898fc0b3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/assets/images/google_logo.png": "b75aecaf9e70a9b1760497e33bcd6db1",
"assets/assets/images/basketball.png": "8055b697296385573ac53b1a12922da0",
"assets/AssetManifest.json": "17c2fcb0f84c471fe2c927bed2c859d8",
"favicon-16x16.png": "5b2d89811dbdde45780850863d4d913e",
"manifest.json": "f4622512655cfd8837f1e6ef2a4ebbfa",
"icons/apple-touch-icon.png": "9e9199ec9d9b60282c33224926f1ade4",
"icons/android-chrome-512x512.png": "6afade3662b1e346b6d46594f8761b8e",
"icons/android-chrome-192x192.png": "105071af0f043eddd6359069f265b005",
"icons/favicon-32x32.png": "16e360dc930c64da4abe854882318342",
"index.html": "0d04e4404a71b6c3f318ed43d4942dca",
"/": "0d04e4404a71b6c3f318ed43d4942dca"
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
