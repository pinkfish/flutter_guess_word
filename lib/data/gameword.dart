import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'gameword.g.dart';

abstract class GameWord implements Built<GameWord, GameWordBuilder> {
  String get word;

  bool get successful;

  GameWord._();

  factory GameWord([updates(GameWordBuilder b)]) = _$GameWord;

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(GameWord.serializer, this);
  }

  static GameWord fromMap(Map<String, dynamic> jsonData) {
    return serializers.deserializeWith(GameWord.serializer, jsonData);
  }

  static Serializer<GameWord> get serializer => _$gameWordSerializer;
}
