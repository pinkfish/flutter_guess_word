import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_word_guesser/data/game.dart';
import 'package:flutter_word_guesser/data/gameword.dart';
import 'package:flutter_word_guesser/data/player.dart';

class GameData {
  static final Random _randomNum = Random.secure();

  @override
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
    "Anonymous Quocka",
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

  Future<void> updateGame({Game game}) async {
    var doc = Firestore.instance.collection("Player").document(game.uid);

    var map = game.toMap();
    if (game.round != null &&
        game.round.roundStart == null &&
        !game.round.completed) {
      // Set the round start to the serever timestamp.
      map["round.roundStart"] = FieldValue.serverTimestamp();
    }
    map["lastUpdate"] = FieldValue.serverTimestamp();
    await doc.updateData(game.toMap());
    return;
  }

  Future<void> deleteGame({String gameUid}) async {
    var doc = Firestore.instance.collection("Player").document(gameUid);

    await doc.delete();
    return;
  }

  Future<void> createGame({Game game}) async {
    var doc = Firestore.instance.collection("Player").document();
    var g = game.rebuild((b) => b..uid = doc.documentID);
    var map = g.toMap();
    map["started"] = FieldValue.serverTimestamp();

    await doc.updateData(game.toMap());
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
      yield Player.fromMap(d.data);
    }
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

  Stream<BuiltList<Game>> getGamesForPlayer({String playerUid}) {}
}
