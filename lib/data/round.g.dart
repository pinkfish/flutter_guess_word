// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Round> _$roundSerializer = new _$RoundSerializer();

class _$RoundSerializer implements StructuredSerializer<Round> {
  @override
  final Iterable<Type> types = const [Round, _$Round];
  @override
  final String wireName = 'Round';

  @override
  Iterable<Object> serialize(Serializers serializers, Round object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currentPlayerUid',
      serializers.serialize(object.currentPlayerUid,
          specifiedType: const FullType(String)),
      'currentCategory',
      serializers.serialize(object.currentCategory,
          specifiedType: const FullType(String)),
      'completed',
      serializers.serialize(object.completed,
          specifiedType: const FullType(bool)),
      'words',
      serializers.serialize(object.words,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GameWord)])),
    ];
    if (object.roundStart != null) {
      result
        ..add('roundStart')
        ..add(serializers.serialize(object.roundStart,
            specifiedType: const FullType(Timestamp)));
    }
    return result;
  }

  @override
  Round deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RoundBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentPlayerUid':
          result.currentPlayerUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currentCategory':
          result.currentCategory = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'completed':
          result.completed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'roundStart':
          result.roundStart = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'words':
          result.words.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GameWord)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Round extends Round {
  @override
  final String currentPlayerUid;
  @override
  final String currentCategory;
  @override
  final bool completed;
  @override
  final Timestamp roundStart;
  @override
  final BuiltList<GameWord> words;
  DateTime __endTime;

  factory _$Round([void Function(RoundBuilder) updates]) =>
      (new RoundBuilder()..update(updates)).build();

  _$Round._(
      {this.currentPlayerUid,
      this.currentCategory,
      this.completed,
      this.roundStart,
      this.words})
      : super._() {
    if (currentPlayerUid == null) {
      throw new BuiltValueNullFieldError('Round', 'currentPlayerUid');
    }
    if (currentCategory == null) {
      throw new BuiltValueNullFieldError('Round', 'currentCategory');
    }
    if (completed == null) {
      throw new BuiltValueNullFieldError('Round', 'completed');
    }
    if (words == null) {
      throw new BuiltValueNullFieldError('Round', 'words');
    }
  }

  @override
  DateTime get endTime => __endTime ??= super.endTime;

  @override
  Round rebuild(void Function(RoundBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoundBuilder toBuilder() => new RoundBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Round &&
        currentPlayerUid == other.currentPlayerUid &&
        currentCategory == other.currentCategory &&
        completed == other.completed &&
        roundStart == other.roundStart &&
        words == other.words;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc(0, currentPlayerUid.hashCode),
                    currentCategory.hashCode),
                completed.hashCode),
            roundStart.hashCode),
        words.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Round')
          ..add('currentPlayerUid', currentPlayerUid)
          ..add('currentCategory', currentCategory)
          ..add('completed', completed)
          ..add('roundStart', roundStart)
          ..add('words', words))
        .toString();
  }
}

class RoundBuilder implements Builder<Round, RoundBuilder> {
  _$Round _$v;

  String _currentPlayerUid;
  String get currentPlayerUid => _$this._currentPlayerUid;
  set currentPlayerUid(String currentPlayerUid) =>
      _$this._currentPlayerUid = currentPlayerUid;

  String _currentCategory;
  String get currentCategory => _$this._currentCategory;
  set currentCategory(String currentCategory) =>
      _$this._currentCategory = currentCategory;

  bool _completed;
  bool get completed => _$this._completed;
  set completed(bool completed) => _$this._completed = completed;

  Timestamp _roundStart;
  Timestamp get roundStart => _$this._roundStart;
  set roundStart(Timestamp roundStart) => _$this._roundStart = roundStart;

  ListBuilder<GameWord> _words;
  ListBuilder<GameWord> get words =>
      _$this._words ??= new ListBuilder<GameWord>();
  set words(ListBuilder<GameWord> words) => _$this._words = words;

  RoundBuilder();

  RoundBuilder get _$this {
    if (_$v != null) {
      _currentPlayerUid = _$v.currentPlayerUid;
      _currentCategory = _$v.currentCategory;
      _completed = _$v.completed;
      _roundStart = _$v.roundStart;
      _words = _$v.words?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Round other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Round;
  }

  @override
  void update(void Function(RoundBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Round build() {
    _$Round _$result;
    try {
      _$result = _$v ??
          new _$Round._(
              currentPlayerUid: currentPlayerUid,
              currentCategory: currentCategory,
              completed: completed,
              roundStart: roundStart,
              words: words.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'words';
        words.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Round', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
