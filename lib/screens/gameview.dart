import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/singlegamebloc.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:flutter_word_guesser/widgets/savingoverlay.dart';

import '../messages.dart';

class GameViewScreen extends StatelessWidget {
  final String gameUid;

  GameViewScreen({this.gameUid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SingleGameBloc(
        gameUid: gameUid,
        db: RepositoryProvider.of<GameData>(context),
      ),
      child: Builder(
        builder: (BuildContext context) => BlocBuilder(
          bloc: BlocProvider.of<SingleGameBloc>(context),
          builder: (BuildContext context, SingleGameState state) {
            Scaffold(
              appBar: AppBar(
                title: state is SingleGameDeleted ||
                        state is SingleGameUninitialized
                    ? Text(Messages.of(context).unknown)
                    : Text(state.game.title),
              ),
              body: SavingOverlay(
                saving: state is SingleGameSaving,
                child: Column(),
              ),
            );
          },
        ),
      ),
    );
  }
}
