import 'package:flutter/material.dart';
import 'package:flutter_word_guesser/blocs/singlegamebloc.dart';
import 'package:flutter_word_guesser/widgets/countdownwidget.dart';

import '../messages.dart';

class SingleGameView extends StatelessWidget {
  final SingleGameState gameState;
  final SingleGameBloc bloc;
  final String myUid;

  SingleGameView({this.gameState, this.myUid, this.bloc});

  @override
  Widget build(BuildContext context) {
    print("Biggles");

    if (gameState is SingleGameUninitialized) {
      return Center(child: Text(Messages.of(context).loading));
    }

    if (gameState is SingleGameDeleted) {
      return Center(child: Text("Game no longer exists"));
    }

    print("Fruitcake");
    // Otherwise show the current state.
    var g = gameState.game;

    if (g.round != null && !g.round.completed) {
      if (g.round.currentPlayerUid == myUid) {
        // Show a button bar with the skip/yes on it.
        return Column(
          children: <Widget>[
            Text("Guessing word"),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text("SKIP"),
                  onPressed: () => _skipWord(context),
                ),
                FlatButton(
                  child: Text("YES"),
                  onPressed: () => _yesWord(context),
                )
              ],
            )
          ],
        );
      } else {
        // Show everyone the word to guess.
        return Column(
          children: <Widget>[
            Text("Word to guess"),
            CountdownWidget(endTime: g.round.endTime),
            Text(g.round.words.last.word),
          ],
        );
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text("No one currently playing"),
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              height: 50,
              child: Text("Animals"),
            ),
          ],
        ),
        ButtonBar(
          children: _getButtons(context),
        )
      ],
    );
  }

  List<Widget> _getButtons(BuildContext context) {
    if (!gameState.game.players.containsKey(myUid)) {
      return <Widget>[
        FlatButton(
          child: Text("JOIN"),
          onPressed: () => bloc.add(SingleGameJoin(myUid)),
        )
      ];
    }
    return <Widget>[
      FlatButton(
        child: Text("START"),
        onPressed: () => _startGame(context, "Animals"),
      )
    ];
  }

  void _skipWord(BuildContext context) {
    bloc.add(SingleGameUpdateWord(false));
  }

  void _yesWord(BuildContext context) {
    bloc.add(SingleGameUpdateWord(true));
  }

  void _startGame(BuildContext context, String category) {
    bloc.add(SingleGameStartRound(category));
  }
}
