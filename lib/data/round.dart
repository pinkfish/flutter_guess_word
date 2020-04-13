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

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_word_guesser/data/gamecategory.dart';

import 'gameword.dart';
import 'serializers.dart';

part 'round.g.dart';

abstract class Round implements Built<Round, RoundBuilder> {
  static final Duration roundLength = Duration(seconds: 60);

  String get currentPlayerUid;

  GameCategory get currentCategory;

  bool get completed;

  /// This is set to the server timestamp of the start
  @nullable
  Timestamp get roundStart;

  BuiltList<GameWord> get words;

  @memoized
  DateTime get endTime {
    if (roundStart == null) {
      return DateTime.now().add(Duration(seconds: 60));
    }
    return roundStart.toDate().add(roundLength);
  }

  Round._();

  factory Round([updates(RoundBuilder b)]) = _$Round;

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(Round.serializer, this);
  }

  static Round fromMap(Map<String, dynamic> jsonData) {
    return serializers.deserializeWith(Round.serializer, jsonData);
  }

  static Serializer<Round> get serializer => _$roundSerializer;
}
