import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/singleplayerbloc.dart';
import 'package:flutter_word_guesser/data/game.dart';
import 'package:flutter_word_guesser/data/player.dart';
import 'package:flutter_word_guesser/widgets/gameinfo.dart';
import 'package:flutter_word_guesser/widgets/playername.dart';

class MainGameView extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  MainGameView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: BlocProvider.of<SinglePlayerBloc>(context),
      listener: (BuildContext context, SinglePlayerState state) {
        if (state is SinglePlayerLoaded && !state.loadedGames) {
          BlocProvider.of<SinglePlayerBloc>(context)
              .add(SinglePlayerLoadGames());
        }
      },
      builder: (BuildContext context, SinglePlayerState state) {
        Widget widget;

        if (state is SinglePlayerLoaded) {
          widget = PlayerName(
            playerState: state,
          );
        }
        return Column(
          children: [
            PlayerName(
              playerState: state,
            ),
            AnimatedList(
              key: _listKey,
              initialItemCount: state.games.length,
              itemBuilder: (BuildContext cointext, int index,
                      Animation<double> animate) =>
                  GameInfo(game: state.games[index]),
            )
          ],
        );
      },
    );
  }
}
