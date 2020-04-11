// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Player> _$playerSerializer = new _$PlayerSerializer();

class _$PlayerSerializer implements StructuredSerializer<Player> {
  @override
  final Iterable<Type> types = const [Player, _$Player];
  @override
  final String wireName = 'Player';

  @override
  Iterable<Object> serialize(Serializers serializers, Player object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'gamesPlayed',
      serializers.serialize(object.gamesPlayed,
          specifiedType: const FullType(int)),
    ];
    if (object.uid != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(object.uid,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Player deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlayerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gamesPlayed':
          result.gamesPlayed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Player extends Player {
  @override
  final String uid;
  @override
  final String name;
  @override
  final int gamesPlayed;

  factory _$Player([void Function(PlayerBuilder) updates]) =>
      (new PlayerBuilder()..update(updates)).build();

  _$Player._({this.uid, this.name, this.gamesPlayed}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Player', 'name');
    }
    if (gamesPlayed == null) {
      throw new BuiltValueNullFieldError('Player', 'gamesPlayed');
    }
  }

  @override
  Player rebuild(void Function(PlayerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlayerBuilder toBuilder() => new PlayerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Player &&
        uid == other.uid &&
        name == other.name &&
        gamesPlayed == other.gamesPlayed;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, uid.hashCode), name.hashCode), gamesPlayed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Player')
          ..add('uid', uid)
          ..add('name', name)
          ..add('gamesPlayed', gamesPlayed))
        .toString();
  }
}

class PlayerBuilder implements Builder<Player, PlayerBuilder> {
  _$Player _$v;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _gamesPlayed;
  int get gamesPlayed => _$this._gamesPlayed;
  set gamesPlayed(int gamesPlayed) => _$this._gamesPlayed = gamesPlayed;

  PlayerBuilder() {
    Player._initializeBuilder(this);
  }

  PlayerBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _name = _$v.name;
      _gamesPlayed = _$v.gamesPlayed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Player other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Player;
  }

  @override
  void update(void Function(PlayerBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Player build() {
    final _$result =
        _$v ?? new _$Player._(uid: uid, name: name, gamesPlayed: gamesPlayed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
