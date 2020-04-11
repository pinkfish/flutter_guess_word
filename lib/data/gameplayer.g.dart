// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameplayer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GamePlayer> _$gamePlayerSerializer = new _$GamePlayerSerializer();

class _$GamePlayerSerializer implements StructuredSerializer<GamePlayer> {
  @override
  final Iterable<Type> types = const [GamePlayer, _$GamePlayer];
  @override
  final String wireName = 'GamePlayer';

  @override
  Iterable<Object> serialize(Serializers serializers, GamePlayer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'rounds',
      serializers.serialize(object.rounds, specifiedType: const FullType(int)),
      'successfulWords',
      serializers.serialize(object.successfulWords,
          specifiedType: const FullType(int)),
      'enabled',
      serializers.serialize(object.enabled,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GamePlayer deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GamePlayerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'rounds':
          result.rounds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'successfulWords':
          result.successfulWords = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'enabled':
          result.enabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GamePlayer extends GamePlayer {
  @override
  final int rounds;
  @override
  final int successfulWords;
  @override
  final bool enabled;

  factory _$GamePlayer([void Function(GamePlayerBuilder) updates]) =>
      (new GamePlayerBuilder()..update(updates)).build();

  _$GamePlayer._({this.rounds, this.successfulWords, this.enabled})
      : super._() {
    if (rounds == null) {
      throw new BuiltValueNullFieldError('GamePlayer', 'rounds');
    }
    if (successfulWords == null) {
      throw new BuiltValueNullFieldError('GamePlayer', 'successfulWords');
    }
    if (enabled == null) {
      throw new BuiltValueNullFieldError('GamePlayer', 'enabled');
    }
  }

  @override
  GamePlayer rebuild(void Function(GamePlayerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GamePlayerBuilder toBuilder() => new GamePlayerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GamePlayer &&
        rounds == other.rounds &&
        successfulWords == other.successfulWords &&
        enabled == other.enabled;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, rounds.hashCode), successfulWords.hashCode),
        enabled.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GamePlayer')
          ..add('rounds', rounds)
          ..add('successfulWords', successfulWords)
          ..add('enabled', enabled))
        .toString();
  }
}

class GamePlayerBuilder implements Builder<GamePlayer, GamePlayerBuilder> {
  _$GamePlayer _$v;

  int _rounds;
  int get rounds => _$this._rounds;
  set rounds(int rounds) => _$this._rounds = rounds;

  int _successfulWords;
  int get successfulWords => _$this._successfulWords;
  set successfulWords(int successfulWords) =>
      _$this._successfulWords = successfulWords;

  bool _enabled;
  bool get enabled => _$this._enabled;
  set enabled(bool enabled) => _$this._enabled = enabled;

  GamePlayerBuilder() {
    GamePlayer._initializeBuilder(this);
  }

  GamePlayerBuilder get _$this {
    if (_$v != null) {
      _rounds = _$v.rounds;
      _successfulWords = _$v.successfulWords;
      _enabled = _$v.enabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GamePlayer other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GamePlayer;
  }

  @override
  void update(void Function(GamePlayerBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GamePlayer build() {
    final _$result = _$v ??
        new _$GamePlayer._(
            rounds: rounds, successfulWords: successfulWords, enabled: enabled);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
