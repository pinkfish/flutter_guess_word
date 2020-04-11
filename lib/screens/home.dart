import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/authenticationbloc.dart';
import 'package:flutter_word_guesser/blocs/singleplayerbloc.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:flutter_word_guesser/widgets/savingoverlay.dart';

import 'maingameview.dart';
import '../services/gamedata.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Guesser"),
      ),
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
              create: (BuildContext context) =>
                  SinglePlayerBloc(
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
