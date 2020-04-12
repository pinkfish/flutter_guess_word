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
