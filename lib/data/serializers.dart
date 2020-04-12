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

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_word_guesser/data/gameplayer.dart';

import 'game.dart';
import 'gamecategory.dart';
import 'gameplayer.dart';
import 'gameword.dart';
import 'player.dart';
import 'round.dart';

part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  Game,
  GameCategory,
  GamePlayer,
  GameWord,
  Player,
  Round,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..add(TimestampSerializer()))
    .build();

class TimestampSerializer implements PrimitiveSerializer<Timestamp> {
  @override
  Timestamp deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is Timestamp) {
      return serialized;
    }
    return Timestamp(0, 0);
  }

  @override
  Iterable serialize(Serializers serializers, Timestamp object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object>[object.nanoseconds.toString()];
  }

  @override
  Iterable<Type> get types => [Timestamp];

  @override
  String get wireName => "Timestamp";
}
