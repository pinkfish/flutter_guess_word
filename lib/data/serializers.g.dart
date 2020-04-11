// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Game.serializer)
      ..add(GamePlayer.serializer)
      ..add(GameWord.serializer)
      ..add(Player.serializer)
      ..add(Round.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GameWord)]),
          () => new ListBuilder<GameWord>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(String), const FullType(GamePlayer)]),
          () => new MapBuilder<String, GamePlayer>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
