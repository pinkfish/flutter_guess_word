/*
 * Copyright (c) 2020 pinkfish
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 */

import 'dart:core';
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'gameplayer.dart';
import 'round.dart';
import 'serializers.dart';

part 'game.g.dart';

abstract class Game implements Built<Game, GameBuilder> {
  @nullable
  String get uid;

  @nullable
  Round get round;

  int get numberOfRounds;

  BuiltMap<String, GamePlayer> get players;

  String get title;

  @nullable
  Timestamp get started;

  @nullable
  Timestamp get lastUpdated;

  static void _initializeBuilder(GameBuilder b) => b
    ..numberOfRounds = 0
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
