import 'dart:async';
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_word_guesser/data/game.dart';
import 'package:flutter_word_guesser/data/gamecategory.dart';
import 'package:flutter_word_guesser/data/gameplayer.dart';
import 'package:flutter_word_guesser/data/player.dart';

class GameData {
  static final Random _randomNum = Random.secure();

  static final List<String> _names = [
    "Anonymous Rabbit",
    "Anonymous Frog",
    "Anonymous Wombat",
    "Anonymous Koala",
    "Anonymous Galah",
    "Anonymous Cockatoo",
    "Anonymous Goana",
    "Anonymous Crockodile",
    "Anonymous Fox",
    "Anonymous Marsupial Cat",
    "Anonymous Rosella",
    "Anonymous Quenda",
    "Anonymous Quokka",
    "Anonymous Wallaby",
    "Anonymous Kangaroo",
    "Anonymous Echidna",
    "Anonymous Emu",
  ];

  Stream<Game> getGame({@required String gameUid}) async* {
    var doc = Firestore.instance.collection("Game").document(gameUid);
    var data = await doc.get();
    if (data.exists) {
      yield Game.fromMap(data.data);
      await for (var d in doc.snapshots()) {
        yield Game.fromMap(d.data);
      }
    } else {
      yield null;
    }
  }

  Future<void> updateGame({@required Game game}) async {
    var doc = Firestore.instance.collection("Game").document(game.uid);

    var map = game.toMap();
    if (game.round != null &&
        game.round.roundStart == null &&
        !game.round.completed) {
      // Set the round start to the serever timestamp.
      map["round.roundStart"] = FieldValue.serverTimestamp();
    }
    map["lastUpdated"] = FieldValue.serverTimestamp();
    await doc.updateData(game.toMap());
    return;
  }

  Future<void> deleteGame({@required String gameUid}) async {
    var doc = Firestore.instance.collection("Game").document(gameUid);

    await doc.delete();
    return;
  }

  Future<void> createGame(
      {@required Game game, @required String playerUid}) async {
    var doc = Firestore.instance.collection("Game").document();
    var g = game.rebuild((b) => b
      ..uid = doc.documentID
      ..players[playerUid] = GamePlayer());
    var map = g.toMap();
    map["started"] = FieldValue.serverTimestamp();
    map["lastUpdated"] = FieldValue.serverTimestamp();
    print(map);

    await doc.setData(map);
  }

  Future<void> joinGame(
      {@required Game game, @required String playerUid}) async {
    var doc = Firestore.instance.collection("Game").document(game.uid);
    var map = <String, dynamic>{"players.$playerUid": GamePlayer().toMap()};
    map["lastUpdated"] = FieldValue.serverTimestamp();

    await doc.updateData(map);
  }

  Stream<Player> getPlayer({@required String playerUid}) async* {
    var doc = Firestore.instance.collection("Player").document(playerUid);
    var data = await doc.get();

    if (data.exists) {
      yield Player.fromMap(data.data);
    } else {
      // Make the user first.
      var player = new Player((b) => b
        ..name = _randomName()
        ..uid = playerUid
        ..gamesPlayed = 0);
      doc.setData(player.toMap());
    }
    await for (var d in doc.snapshots()) {
      if (d.exists) {
        yield Player.fromMap(d.data);
      }
    }
  }

  Stream<GameCategory> getCategory({@required String categoryUid}) async* {
    var doc = Firestore.instance.collection("Category").document(categoryUid);
    var data = await doc.get();

    if (data.exists) {
      yield GameCategory.fromMap(data.data);
      await for (var d in doc.snapshots()) {
        if (d.exists) {
          yield GameCategory.fromMap(d.data);
        }
      }
    } else {
      yield null;
    }
  }

  Future<void> updateCategory({@required GameCategory category}) async {
    var doc = Firestore.instance.collection("Category").document(category.uid);

    var map = category.toMap();
    await doc.updateData(map);
    return;
  }

  String _randomName() {
    return _names[_randomNum.nextInt(_names.length)];
  }

  Future<void> updatePlayer({Player player}) async {
    var doc = Firestore.instance.collection("Player").document(player.uid);

    await doc.updateData(player.toMap());
    return;
  }

  Future<void> deletePlayer({String playerUid}) async {
    var doc = Firestore.instance.collection("Player").document(playerUid);

    await doc.delete();
    return;
  }

  Stream<BuiltList<Game>> getGamesForPlayer({String playerUid}) async* {
    var docs = Firestore.instance
        .collection("Game")
        .where("players.$playerUid.enabled", isEqualTo: true);
    print("players.$playerUid.enabled");
    var first = await docs.getDocuments();
    yield BuiltList.of(first.documents.map((e) => Game.fromMap(e.data)));

    await for (var next in docs.snapshots()) {
      yield BuiltList.of(next.documents.map((e) => Game.fromMap(e.data)));
    }
  }

  Stream<BuiltList<String>> getWordsForCategory({String categoryUid}) async* {
    var docs = Firestore.instance
        .collection("Category")
        .document(categoryUid)
        .collection("Words");
    var first = await docs.getDocuments();
    yield BuiltList.of(first.documents.map((e) => e.data as String));

    await for (var next in docs.snapshots()) {
      yield BuiltList.of(next.documents.map((e) => e.data as String));
    }
  }

  Stream<BuiltList<GameCategory>> getAllCategories() async* {
    var docs = Firestore.instance.collection("Category");
    var first = await docs.getDocuments();
    yield BuiltList.of(
        first.documents.map((e) => GameCategory.fromMap(e.data)));

    await for (var next in docs.snapshots()) {
      yield BuiltList.of(
          next.documents.map((e) => GameCategory.fromMap(e.data)));
    }
  }
}
