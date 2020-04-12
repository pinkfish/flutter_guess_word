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
import 'package:flutter_word_guesser/blocs/singleplayerbloc.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:flutter_word_guesser/widgets/guesserdrawer.dart';
import 'package:flutter_word_guesser/widgets/savingoverlay.dart';

import '../services/gamedata.dart';
import 'maingameview.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Guesser"),
      ),
      drawer: GuesserDrawer(),
      body: BlocConsumer(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        listener: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationLoggedIn) {
            // Do yay and more yay bananas
          }
          if (state is AuthenticationLoggedOut) {
            // Try and log in anonymously.
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEventAsAnonymous());
          }
        },
        builder: (BuildContext context, AuthenticationState state) {
          return SavingOverlay(
            saving: state is AuthenticationValidating,
            child: state is AuthenticationLoggedIn
                ? BlocProvider(
                    create: (BuildContext context) => SinglePlayerBloc(
                        db: RepositoryProvider.of<GameData>(context),
                        playerUid: state.user.uid),
                    child: MainGameView(),
                  )
                : Text(
                    'Not logged in',
                  ),
          );
        },
      ),
    );
  }
}
