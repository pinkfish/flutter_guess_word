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
