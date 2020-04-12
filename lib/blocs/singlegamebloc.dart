/*
 * Copyright (c) 2020 pinkfish
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 */

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_word_guesser/data/game.dart';
import 'package:flutter_word_guesser/data/gamecategory.dart';
import 'package:flutter_word_guesser/data/gameword.dart';
import 'package:flutter_word_guesser/data/round.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:meta/meta.dart';
import 'package:synchronized/synchronized.dart';

///
/// The data associated with the game.
///
abstract class SingleGameState extends Equatable {
  final Game game;
  final bool loadedCategory;
  final BuiltList<String> words;

  SingleGameState({
    @required this.game,
    @required this.loadedCategory,
    @required this.words,
  });

  @override
  List<Object> get props => [game];
}

///
/// We have a game, default state.
///
class SingleGameLoaded extends SingleGameState {
  SingleGameLoaded({
    @required Game game,
    SingleGameState state,
    bool loadedCategory,
    BuiltList<String> words,
  }) : super(
    game: game ?? state.game,
    loadedCategory: loadedCategory ?? state.loadedCategory,
    words: words ?? state.words,
  );

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
      : super(
    game: singleGameState.game,
    loadedCategory: singleGameState.loadedCategory,
    words: singleGameState.words,
  );

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
      : super(
          game: singleGameState.game,
          loadedCategory: singleGameState.loadedCategory,
          words: singleGameState.words,
        );

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
      : super(
    game: singleGameState.game,
    loadedCategory: singleGameState.loadedCategory,
    words: singleGameState.words,
  );

  @override
  String toString() {
    return 'SingleGameSaveFailed{}';
  }
}

///
/// Game got deleted.
///
class SingleGameDeleted extends SingleGameState {
  SingleGameDeleted()
      : super(
    game: null,
    loadedCategory: false,
    words: BuiltList.of([]),
  );

  @override
  String toString() {
    return 'SingleGameDeleted{}';
  }
}

///
/// What the system has not yet read the game state.
///
class SingleGameUninitialized extends SingleGameState {
  SingleGameUninitialized()
      : super(
    game: null,
    loadedCategory: false,
    words: BuiltList.of([]),
  );
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
  final GameCategory category;

  SingleGameStartRound(this.category);

  @override
  List<Object> get props => [category];
}

///
/// Deletes this game from the world.
///
class SingleGameJoin extends SingleGameEvent {
  final String playerUid;

  SingleGameJoin(this.playerUid);

  @override
  List<Object> get props => [playerUid];
}

///
/// Loads the category associated with this round.
///
class SingleGameLoadCategory extends SingleGameEvent {
  SingleGameLoadCategory();

  @override
  List<Object> get props => [];
}

class _SingleGameNewGame extends SingleGameEvent {
  final Game newGame;

  _SingleGameNewGame({@required this.newGame});

  @override
  List<Object> get props => [newGame];
}

class _SingleGameNewWords extends SingleGameEvent {
  final BuiltList<String> words;

  _SingleGameNewWords({@required this.words});

  @override
  List<Object> get props => [words];
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

  static final Random _randomNum = Random.secure();

  StreamSubscription<Game> _gameSub;
  StreamSubscription<BuiltList<String>> _wordsSub;
  final Lock _lock = Lock();

  String lastCategoryUid;

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
    _wordsSub?.cancel();
    _wordsSub = null;
    await super.close();
  }

  bool cleanupCategory() {
    if (state.game?.round?.currentCategory?.uid != lastCategoryUid) {
      _wordsSub?.cancel();
      _wordsSub = null;
      lastCategoryUid = state.game.round.currentCategory.uid;
      return true;
    }
    return false;
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
        if (cleanupCategory()) {
          yield SingleGameLoaded(
            game: state.game,
            loadedCategory: false,
            words: BuiltList.of([]),
          );
        }
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
        String word;
        if (state.loadedCategory) {
          word = state.words[_randomNum.nextInt(state.words.length)];
        } else {
          var words = await db
              .getWordsForCategory(
              categoryUid: state.game.round.currentCategory.uid)
              .first;
          word = words[_randomNum.nextInt(state.words.length)];
        }

        bAllWords.add(
          GameWord(
                (b) => b..word = word,
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
        round.currentCategory = event.category.toBuilder();
        round.completed = false;

        String word;
        if (lastCategoryUid == event.category.uid && state.loadedCategory) {
          word = state.words[_randomNum.nextInt(state.words.length)];
        } else {
          var words = await db
              .getWordsForCategory(
              categoryUid: state.game.round.currentCategory.uid)
              .first;
          word = words[_randomNum.nextInt(state.words.length)];
        }
        round.words.add(GameWord((b) => b..word = word));

        // Update the set, choose a new word from the category.
        await db.updateGame(game: state.game.rebuild((b) => b..round = round));
        yield SingleGameSaveSuccessful(singleGameState: state);
      } catch (e) {
        yield SingleGameSaveFailed(singleGameState: state, error: e);
      }
    }

    if (event is SingleGameJoin) {
      yield SingleGameSaving(singleGameState: state);
      try {
        await db.joinGame(game: state.game, playerUid: event.playerUid);
        yield SingleGameSaveSuccessful(singleGameState: state);
      } catch (e) {
        yield SingleGameSaveFailed(singleGameState: state, error: e);
      }
    }

    if (event is SingleGameLoadCategory) {
      if (state.game.round != null &&
          state.game.round.currentCategory != null) {
        _lock.synchronized(() {
          _setupWordsSub();
        });
      }
    }

    if (event is _SingleGameNewWords) {
      yield SingleGameLoaded(
          game: state.game,
          state: state,
          words: event.words,
          loadedCategory: true);
    }
  }

  void _setupWordsSub() {
    _wordsSub?.cancel();
    _wordsSub = db
        .getWordsForCategory(categoryUid: state.game.round.currentCategory.uid)
        .listen((event) {
      add(_SingleGameNewWords(words: event));
    });
  }
}
