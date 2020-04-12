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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/authenticationbloc.dart';
import 'package:flutter_word_guesser/blocs/categorybloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SingleGameBloc(
            gameUid: gameUid,
            db: RepositoryProvider.of<GameData>(context),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => CategoryBloc(
            db: RepositoryProvider.of<GameData>(context),
          ),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) => BlocBuilder(
          bloc: BlocProvider.of<SingleGameBloc>(context),
          builder: (BuildContext context, SingleGameState state) {
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
                        !(authState is AuthenticationLoggedIn),
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
