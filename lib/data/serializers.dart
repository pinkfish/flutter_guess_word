// Copyright (c) 2016, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

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
