// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Game> _$gameSerializer = new _$GameSerializer();

class _$GameSerializer implements StructuredSerializer<Game> {
  @override
  final Iterable<Type> types = const [Game, _$Game];
  @override
  final String wireName = 'Game';

  @override
  Iterable<Object> serialize(Serializers serializers, Game object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'numberOfRounds',
      serializers.serialize(object.numberOfRounds,
          specifiedType: const FullType(int)),
      'players',
      serializers.serialize(object.players,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(GamePlayer)])),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    if (object.uid != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(object.uid,
            specifiedType: const FullType(String)));
    }
    if (object.round != null) {
      result
        ..add('round')
        ..add(serializers.serialize(object.round,
            specifiedType: const FullType(Round)));
    }
    if (object.started != null) {
      result
        ..add('started')
        ..add(serializers.serialize(object.started,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.lastUpdated != null) {
      result
        ..add('lastUpdated')
        ..add(serializers.serialize(object.lastUpdated,
            specifiedType: const FullType(Timestamp)));
    }
    return result;
  }

  @override
  Game deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GameBuilder();

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
        case 'round':
          result.round.replace(serializers.deserialize(value,
              specifiedType: const FullType(Round)) as Round);
          break;
        case 'numberOfRounds':
          result.numberOfRounds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'players':
          result.players.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(GamePlayer)])));
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'started':
          result.started = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'lastUpdated':
          result.lastUpdated = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
      }
    }

    return result.build();
  }
}

class _$Game extends Game {
  @override
  final String uid;
  @override
  final Round round;
  @override
  final int numberOfRounds;
  @override
  final BuiltMap<String, GamePlayer> players;
  @override
  final String title;
  @override
  final Timestamp started;
  @override
  final Timestamp lastUpdated;

  factory _$Game([void Function(GameBuilder) updates]) =>
      (new GameBuilder()..update(updates)).build();

  _$Game._(
      {this.uid,
      this.round,
      this.numberOfRounds,
      this.players,
      this.title,
      this.started,
      this.lastUpdated})
      : super._() {
    if (numberOfRounds == null) {
      throw new BuiltValueNullFieldError('Game', 'numberOfRounds');
    }
    if (players == null) {
      throw new BuiltValueNullFieldError('Game', 'players');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Game', 'title');
    }
  }

  @override
  Game rebuild(void Function(GameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GameBuilder toBuilder() => new GameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Game &&
        uid == other.uid &&
        round == other.round &&
        numberOfRounds == other.numberOfRounds &&
        players == other.players &&
        title == other.title &&
        started == other.started &&
        lastUpdated == other.lastUpdated;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, uid.hashCode), round.hashCode),
                        numberOfRounds.hashCode),
                    players.hashCode),
                title.hashCode),
            started.hashCode),
        lastUpdated.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Game')
          ..add('uid', uid)
          ..add('round', round)
          ..add('numberOfRounds', numberOfRounds)
          ..add('players', players)
          ..add('title', title)
          ..add('started', started)
          ..add('lastUpdated', lastUpdated))
        .toString();
  }
}

class GameBuilder implements Builder<Game, GameBuilder> {
  _$Game _$v;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  RoundBuilder _round;
  RoundBuilder get round => _$this._round ??= new RoundBuilder();
  set round(RoundBuilder round) => _$this._round = round;

  int _numberOfRounds;
  int get numberOfRounds => _$this._numberOfRounds;
  set numberOfRounds(int numberOfRounds) =>
      _$this._numberOfRounds = numberOfRounds;

  MapBuilder<String, GamePlayer> _players;
  MapBuilder<String, GamePlayer> get players =>
      _$this._players ??= new MapBuilder<String, GamePlayer>();
  set players(MapBuilder<String, GamePlayer> players) =>
      _$this._players = players;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  Timestamp _started;
  Timestamp get started => _$this._started;
  set started(Timestamp started) => _$this._started = started;

  Timestamp _lastUpdated;
  Timestamp get lastUpdated => _$this._lastUpdated;
  set lastUpdated(Timestamp lastUpdated) => _$this._lastUpdated = lastUpdated;

  GameBuilder() {
    Game._initializeBuilder(this);
  }

  GameBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _round = _$v.round?.toBuilder();
      _numberOfRounds = _$v.numberOfRounds;
      _players = _$v.players?.toBuilder();
      _title = _$v.title;
      _started = _$v.started;
      _lastUpdated = _$v.lastUpdated;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Game other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Game;
  }

  @override
  void update(void Function(GameBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Game build() {
    _$Game _$result;
    try {
      _$result = _$v ??
          new _$Game._(
              uid: uid,
              round: _round?.build(),
              numberOfRounds: numberOfRounds,
              players: players.build(),
              title: title,
              started: started,
              lastUpdated: lastUpdated);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'round';
        _round?.build();

        _$failedField = 'players';
        players.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Game', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
