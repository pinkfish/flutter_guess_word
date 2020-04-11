import 'dart:core';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'gameplayer.g.dart';

abstract class GamePlayer implements Built<GamePlayer, GamePlayerBuilder> {
  int get rounds;

  int get successfulWords;

  bool get enabled;

  static void _initializeBuilder(GamePlayerBuilder b) => b
    ..rounds = 0
    ..successfulWords = 0
    ..enabled = true;

  GamePlayer._();

  factory GamePlayer([updates(GamePlayerBuilder b)]) = _$GamePlayer;

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(GamePlayer.serializer, this);
  }

  static GamePlayer fromMap(Map<String, dynamic> jsonData) {
    return serializers.deserializeWith(GamePlayer.serializer, jsonData);
  }

  static Serializer<GamePlayer> get serializer => _$gamePlayerSerializer;
}
