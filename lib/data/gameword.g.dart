// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameword.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GameWord> _$gameWordSerializer = new _$GameWordSerializer();

class _$GameWordSerializer implements StructuredSerializer<GameWord> {
  @override
  final Iterable<Type> types = const [GameWord, _$GameWord];
  @override
  final String wireName = 'GameWord';

  @override
  Iterable<Object> serialize(Serializers serializers, GameWord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'word',
      serializers.serialize(object.word, specifiedType: const FullType(String)),
      'successful',
      serializers.serialize(object.successful,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GameWord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GameWordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'word':
          result.word = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'successful':
          result.successful = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GameWord extends GameWord {
  @override
  final String word;
  @override
  final bool successful;

  factory _$GameWord([void Function(GameWordBuilder) updates]) =>
      (new GameWordBuilder()..update(updates)).build();

  _$GameWord._({this.word, this.successful}) : super._() {
    if (word == null) {
      throw new BuiltValueNullFieldError('GameWord', 'word');
    }
    if (successful == null) {
      throw new BuiltValueNullFieldError('GameWord', 'successful');
    }
  }

  @override
  GameWord rebuild(void Function(GameWordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GameWordBuilder toBuilder() => new GameWordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameWord &&
        word == other.word &&
        successful == other.successful;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, word.hashCode), successful.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GameWord')
          ..add('word', word)
          ..add('successful', successful))
        .toString();
  }
}

class GameWordBuilder implements Builder<GameWord, GameWordBuilder> {
  _$GameWord _$v;

  String _word;
  String get word => _$this._word;
  set word(String word) => _$this._word = word;

  bool _successful;
  bool get successful => _$this._successful;
  set successful(bool successful) => _$this._successful = successful;

  GameWordBuilder();

  GameWordBuilder get _$this {
    if (_$v != null) {
      _word = _$v.word;
      _successful = _$v.successful;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameWord other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GameWord;
  }

  @override
  void update(void Function(GameWordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GameWord build() {
    final _$result =
        _$v ?? new _$GameWord._(word: word, successful: successful);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
