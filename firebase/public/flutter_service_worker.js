'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "4ef11d63911e726070cf37ea2fd358ca",
"main.dart.js_1.part.js": "1ab35bdd29118181f41801317e6c9335",
"main.dart.js_1.part.js.map": "74cd6811304c0cf8e6066afa89802110",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/AssetManifest.json": "17c2fcb0f84c471fe2c927bed2c859d8",
"assets/LICENSE": "49e106ceae6b4906fad93a2610f3727e",
"assets/assets/images/google_logo.png": "b75aecaf9e70a9b1760497e33bcd6db1",
"assets/assets/images/basketball.png": "8055b697296385573ac53b1a12922da0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "fe1545ef4dd1eef2f1e25528898fc0b3",
<<<<<<< HEAD
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "7dc9f87ea303eb23aa918955db4bce4c",
"/": "7dc9f87ea303eb23aa918955db4bce4c",
"main.dart.js": "4b74d7b4920d6ad122c60efe8900a6bc",
"main.dart.js_1.part.js": "b404026fa950e7d9fa5edad4744a9fc8",
"main.dart.js_1.part.js.map": "cc4c6ab897f268986b4ca99647749c9f",
"manifest.json": "4fe4791175a1a959acd6daba03079ea6"
=======
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "0621fb7723859a382fc19210904f6578",
"main.dart.js": "276118eec9ecb0f8a60baacd0c6b824d",
"index.html": "87a8c941b5c71caa4819187fd9a52a5d",
"/": "87a8c941b5c71caa4819187fd9a52a5d"
>>>>>>> 4e4590af6b47cf6be274825a53f67334e1c4fca6
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
