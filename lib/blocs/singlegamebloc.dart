import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_word_guesser/data/game.dart';
import 'package:flutter_word_guesser/data/gameword.dart';
import 'package:flutter_word_guesser/data/round.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:meta/meta.dart';

///
/// The data associated with the game.
///
abstract class SingleGameState extends Equatable {
  final Game game;

  SingleGameState({@required this.game});

  @override
  List<Object> get props => [game];
}

///
/// We have a game, default state.
///
class SingleGameLoaded extends SingleGameState {
  SingleGameLoaded(
      {@required Game game,
      SingleGameState state,
      bool loadedGamed,
      BuiltList<Game> games})
      : super(game: game ?? state.game);

  @override
  String toString() {
    return 'SingleGameLoaded{}';
  }
}

///
/// Saving operation in progress.
///
class SingleGameSaving extends SingleGameState {
  SingleGameSaving({@required SingleGameState singleGameState})
      : super(game: singleGameState.game);

  @override
  String toString() {
    return 'SingleGameSaving{}';
  }
}

///
/// Save operation was successful.
///
class SingleGameSaveSuccessful extends SingleGameState {
  SingleGameSaveSuccessful({@required SingleGameState singleGameState})
      : super(game: singleGameState.game);

  @override
  String toString() {
    return 'SingleGameSaveSuccessful{}';
  }
}

///
/// Saving operation failed (goes back to loaded for success).
///
class SingleGameSaveFailed extends SingleGameState {
  final Error error;

  SingleGameSaveFailed({@required SingleGameState singleGameState, this.error})
      : super(game: singleGameState.game);

  @override
  String toString() {
    return 'SingleGameSaveFailed{}';
  }
}

///
/// Game got deleted.
///
class SingleGameDeleted extends SingleGameState {
  SingleGameDeleted() : super(game: null);

  @override
  String toString() {
    return 'SingleGameDeleted{}';
  }
}

///
/// What the system has not yet read the game state.
///
class SingleGameUninitialized extends SingleGameState {
  SingleGameUninitialized() : super(game: null);
}

abstract class SingleGameEvent extends Equatable {}

///
/// Updates the game (writes it out to firebase.
///
class SingleGameUpdate extends SingleGameEvent {
  final Game game;

  SingleGameUpdate({@required this.game});

  @override
  List<Object> get props => [game];
}

///
/// Deletes this game from the world.
///
class SingleGameDelete extends SingleGameEvent {
  SingleGameDelete();

  @override
  List<Object> get props => [];
}

///
/// Deletes this game from the world.
///
class SingleGameUpdateWord extends SingleGameEvent {
  final bool successfull;

  SingleGameUpdateWord(this.successfull);

  @override
  List<Object> get props => [this.successfull];
}

///
/// Deletes this game from the world.
///
class SingleGameStartRound extends SingleGameEvent {
  final String category;

  SingleGameStartRound(this.category);

  @override
  List<Object> get props => [];
}

class _SingleGameNewGame extends SingleGameEvent {
  final Game newGame;

  _SingleGameNewGame({@required this.newGame});

  @override
  List<Object> get props => [newGame];
}

class _SingleGameDeleted extends SingleGameEvent {
  _SingleGameDeleted();

  @override
  List<Object> get props => [];
}

///
/// Bloc to handle updates and state of a specific game.
///
class SingleGameBloc extends Bloc<SingleGameEvent, SingleGameState> {
  final String gameUid;
  final GameData db;

  StreamSubscription<Game> _gameSub;
  StreamSubscription<BuiltList<Game>> _gameEventSub;

  SingleGameBloc({@required this.db, @required this.gameUid}) {
    _gameSub = db.getGame(gameUid: gameUid).listen(_onGameUpdate);
  }

  void _onGameUpdate(Game g) {
    if (g != this.state.game) {
      if (g != null) {
        add(_SingleGameNewGame(newGame: g));
      } else {
        add(_SingleGameDeleted());
      }
    }
  }

  @override
  Future<void> close() async {
    _gameSub?.cancel();
    _gameSub = null;
    _gameEventSub?.cancel();
    _gameEventSub = null;
    await super.close();
  }

  @override
  SingleGameState get initialState {
    return SingleGameUninitialized();
  }

  @override
  Stream<SingleGameState> mapEventToState(SingleGameEvent event) async* {
    if (event is _SingleGameNewGame) {
      yield SingleGameLoaded(game: event.newGame, state: state);
    }

    // The game is deleted.
    if (event is _SingleGameDeleted) {
      yield SingleGameDeleted();
    }

    if (event is SingleGameDelete) {
      yield SingleGameSaving(singleGameState: state);
      try {
        Game game = state.game;
        await db.deleteGame(gameUid: game.uid);
        yield SingleGameDeleted();
      } catch (e) {
        yield SingleGameSaveFailed(singleGameState: state, error: e);
      }
    }

    // Save the game.
    if (event is SingleGameUpdate) {
      yield SingleGameSaving(singleGameState: state);
      try {
        Game game = event.game;
        await db.updateGame(game: game);
        yield SingleGameSaveSuccessful(singleGameState: state);
      } catch (e) {
        yield SingleGameSaveFailed(singleGameState: state, error: e);
      }
    }

    if (event is SingleGameUpdateWord) {
      yield SingleGameSaving(singleGameState: state);
      try {
        var bAllWords = state.game.round.words.toBuilder();
        var wordB = bAllWords.last.toBuilder();
        wordB.successful = event.successfull;
        bAllWords[bAllWords.length - 1] = wordB.build();

        // Add in a new word
        bAllWords.add(
          GameWord(
            (b) => b
              ..word =
                  getRandomWordForCategory(state.game.round.currentCategory),
          ),
        );

        // Update the set, choose a new word from the category.
        Game game = state.game.rebuild((b) => b..round.words = bAllWords);
        await db.updateGame(game: game);
        yield SingleGameSaveSuccessful(singleGameState: state);
      } catch (e) {
        yield SingleGameSaveFailed(singleGameState: state, error: e);
      }
    }

    if (event is SingleGameStartRound) {
      yield SingleGameSaving(singleGameState: state);
      try {
        var round = RoundBuilder();
        // User has to exist to be in here.
        round.currentPlayerUid =
            (await FirebaseAuth.instance.currentUser()).uid;
        round.currentCategory = event.category;
        round.words.add(GameWord((b) => b..word = "Frog"));
        round.completed = false;

        // Update the set, choose a new word from the category.
        await db.updateGame(game: state.game.rebuild((b) => b..round = round));
        yield SingleGameSaveSuccessful(singleGameState: state);
      } catch (e) {
        yield SingleGameSaveFailed(singleGameState: state, error: e);
      }
    }
  }

  String getRandomWordForCategory(String category) {
    switch (category) {
      case "Animal":
        return "frog";
      default:
        return "unknown";
    }
  }
}
