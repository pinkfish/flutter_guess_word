import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/authenticationbloc.dart';
import 'package:flutter_word_guesser/blocs/singlegamebloc.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:flutter_word_guesser/widgets/savingoverlay.dart';
import 'package:flutter_word_guesser/widgets/singlegameview.dart';

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
            print("Scoffles");
            return Scaffold(
              appBar: AppBar(
                title: state is SingleGameDeleted ||
                        state is SingleGameUninitialized
                    ? Text(Messages.of(context).unknown)
                    : Text(state.game.title),
              ),
              body: BlocBuilder(
                bloc: BlocProvider.of<AuthenticationBloc>(context),
                builder: (BuildContext context, AuthenticationState authState) {
                  Widget view;
                  if (authState is AuthenticationLoggedIn) {
                    view = SingleGameView(
                      gameState: state,
                      bloc: BlocProvider.of<SingleGameBloc>(context),
                      myUid: BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user
                          .uid,
                    );
                  }
                  if (authState is AuthenticationUninitialized) {
                    view = Text(Messages.of(context).loading);
                  }
                  if (authState is AuthenticationLoggedOut) {
                    view = Text("Logged out?");
                  }

                  return SavingOverlay(
                    saving: state is SingleGameSaving ||
                        !(state is AuthenticationLoggedIn),
                    child: view,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
