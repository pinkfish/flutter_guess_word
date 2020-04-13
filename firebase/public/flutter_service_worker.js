'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "4ef11d63911e726070cf37ea2fd358ca",
"main.dart.js_1.part.js": "e5a59f0690e04de51248588e468b7edd",
"main.dart.js_1.part.js.map": "74cd6811304c0cf8e6066afa89802110",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/AssetManifest.json": "17c2fcb0f84c471fe2c927bed2c859d8",
"assets/LICENSE": "49e106ceae6b4906fad93a2610f3727e",
"assets/assets/images/google_logo.png": "b75aecaf9e70a9b1760497e33bcd6db1",
"assets/assets/images/basketball.png": "8055b697296385573ac53b1a12922da0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "fe1545ef4dd1eef2f1e25528898fc0b3",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "0621fb7723859a382fc19210904f6578",
"main.dart.js": "a08ac6b6e7aceb33a0a49c9e3b139973",
"index.html": "2d08c50f0b6ed6dd6d16b4cdfef5131b",
"/": "2d08c50f0b6ed6dd6d16b4cdfef5131b"
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
