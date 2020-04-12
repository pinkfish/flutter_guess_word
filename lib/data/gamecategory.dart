import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'gamecategory.g.dart';

abstract class GameCategory
    implements Built<GameCategory, GameCategoryBuilder> {
  @nullable
  String get uid;

  String get name;

  GameCategory._();

  factory GameCategory([updates(GameCategoryBuilder b)]) = _$GameCategory;

  Map<String, dynamic> toMap() {
    return serializers.serializeWith(GameCategory.serializer, this);
  }

  static GameCategory fromMap(Map<String, dynamic> jsonData) {
    return serializers.deserializeWith(GameCategory.serializer, jsonData);
  }

  static Serializer<GameCategory> get serializer => _$gameCategorySerializer;
}
