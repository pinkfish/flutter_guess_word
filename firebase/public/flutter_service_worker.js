'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon-16x16.png": "5a77a7fd46b82d722726cf8e8adaf1e4",
"favicon.ico": "3f3156d422e172ce9be45916896514ec",
"manifest.json": "f4622512655cfd8837f1e6ef2a4ebbfa",
"main.dart.js_1.part.js": "d39b3730f8ae5b64383853611643f489",
"main.dart.js_1.part.js.map": "74cd6811304c0cf8e6066afa89802110",
"icons/android-chrome-192x192.png": "0f56263a4a36000600bbc49c7d8570fb",
"icons/android-chrome-512x512.png": "a87e58b97ba9e611b7660ab406907fd0",
"icons/apple-touch-icon.png": "7e485ca4aadda526731ec60aa4d5dece",
"icons/favicon-32x32.png": "b79853c7ddad87183f1cb000e25be6aa",
"assets/AssetManifest.json": "17c2fcb0f84c471fe2c927bed2c859d8",
"assets/LICENSE": "49e106ceae6b4906fad93a2610f3727e",
"assets/assets/images/google_logo.png": "b75aecaf9e70a9b1760497e33bcd6db1",
"assets/assets/images/basketball.png": "8055b697296385573ac53b1a12922da0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "fe1545ef4dd1eef2f1e25528898fc0b3",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "0621fb7723859a382fc19210904f6578",
"main.dart.js": "da7169532de1e045b4a0d4ba3c1c2da5",
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
