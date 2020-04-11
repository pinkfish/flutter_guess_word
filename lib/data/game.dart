import 'dart:core';
import 'dart:math';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';
import 'round.dart';

part 'game.g.dart';

abstract class Game implements Built<Game, GameBuilder> {
  @nullable
  String get uid;

  @nullable
  Round get round;

  int get numberOfRounds;

  int get players;

  String get title;

  DateTime get started;

  DateTime get lastUpdate;

  static void _initializeBuilder(GameBuilder b) => b
    ..numberOfRounds = 0
    ..players = 0
    ..started = DateTime.now().toUtc()
    ..title = getRandomName();

  Game._();

  factory Game([updates(GameBuilder b)]) = _$Game;

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(Game.serializer, this);
  }

  static Game fromMap(Map<String, dynamic> jsonData) {
    return serializers.deserializeWith(Game.serializer, jsonData);
  }

  static Serializer<Game> get serializer => _$gameSerializer;

  static final List<String> _wordList1 = [
    "The Day and the ",
    "The Glass and the ",
    "The Clean and the ",
    "The Magic and the ",
    "The Iron and the",
    "The Gold and the ",
    "The Silver and the ",
    "The Bronze and the ",
    "The Ice and the ",
    "The Lies and the ",
    "The Morning and the ",
    "The Sea and the ",
    "The Hunt and the ",
    "The Faith and the ",
    "The Silk and the ",
    "The Jest and the ",
    "The Leaf and the ",
    "The River and the ",
    "The Ghost and the ",
    "The War and the ",
    "The Treasure and the ",
    "The Trap and the ",
    "The Vandal and the ",
    "The Sunken and the ",
    "The Derelict and the",
    "The Seeking and the ",
    "The Ice and the ",
    "The Foundling and the ",
    "The Orphaned and the ",
    "The Vengeful and the ",
    "The Brass and the ",
    "The Amber and the ",
    "The Jade and the ",
    "The Naked and the ",
    "The Miracle and the ",
    "The Winter and the ",
    "The Summer and the ",
    "The Autumn and the ",
    "The Raven and the ",
    "The Secret and the ",
    "The Lost and the ",
    "The Midnight and the ",
    "The Sky and the ",
    "The Hidden and the "
  ];

  static final List<String> _wordList2 = [
    "Night",
    "Stone",
    "Proven",
    "Unclean",
    "Rift",
    "Tree",
    "Stone",
    "Hills",
    "Sky",
    "Sea",
    "Dead",
    "Gods",
    "Bright",
    "Restless",
    "Blade",
    "Cloaked",
    "Door",
    "Road",
    "Wind",
    "Ship",
    "Buried",
    "Cliffs",
    "Paper",
    "Hidden",
    "Cave",
    "Island",
    "Harbour",
    "Tribe",
    "Walkers",
    "Thorns",
    "Wings",
    "City",
    "Skull",
    "Blessed",
    "Stars",
    "Moon",
    "Circle",
    "Wave",
    "Light",
    "Dark",
    "Tide",
    "Fates",
    "Spelled",
    "Storm",
    "Nightborn",
    "Sunborn",
    "Noon",
    "Mythborn",
    "Inheritors",
    "Warriors",
    "Song",
    "Jewelled"
  ];

  static final Random _randomNum = Random.secure();

  static String getRandomName() {
    return _wordList1[_randomNum.nextInt(_wordList1.length)] +
        " " +
        _wordList2[_randomNum.nextInt(_wordList2.length)];
  }
}
