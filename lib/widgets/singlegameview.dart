import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/categorybloc.dart';
import 'package:flutter_word_guesser/blocs/singlegamebloc.dart';
import 'package:flutter_word_guesser/widgets/countdownwidget.dart';

import '../messages.dart';
import 'categoryitem.dart';

class SingleGameView extends StatelessWidget {
  final SingleGameState gameState;
  final SingleGameBloc bloc;
  final String myUid;

  SingleGameView({this.gameState, this.myUid, this.bloc});

  @override
  Widget build(BuildContext context) {
    if (gameState is SingleGameUninitialized) {
      return Center(child: Text(Messages.of(context).loading));
    }

    if (gameState is SingleGameDeleted) {
      return Center(child: Text("Game no longer exists"));
    }

    // Otherwise show the current state.
    var g = gameState.game;

    if (g.round != null && !g.round.completed) {
      if (g.round.currentPlayerUid == myUid) {
        if (!gameState.loadedCategory) {
          bloc.add(SingleGameLoadCategory());
        }
        // Show a button bar with the skip/yes on it.
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Guessing word", style: Theme.of(context).textTheme.headline5),
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
            ),
            CountdownWidget(
                endTime: g.round.endTime,
                style: Theme.of(context).textTheme.headline2),
          ],
        );
      } else {
        // Show everyone the word to guess.
        return Column(
          children: <Widget>[
            Text("Word to guess"),
            CountdownWidget(
                endTime: g.round.endTime,
                style: Theme.of(context).textTheme.headline2),
            Text(g.round.words.last.word,
                style: Theme.of(context).textTheme.headline4),
          ],
        );
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("No one currently playing",
            style: Theme
                .of(context)
                .textTheme
                .headline5),
        ButtonBar(
          children: _getButtons(context),
        ),
        Divider(),
        Text("Pick a Category", style: Theme
            .of(context)
            .textTheme
            .headline6),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder(
              bloc: BlocProvider.of<CategoryBloc>(context),
              builder: (BuildContext contect, CategoryState categoryState) {
                if (categoryState is CategoryUninitialized) {
                  return CircularProgressIndicator();
                }
                return ListView(
                  shrinkWrap: true,
                  children: categoryState.categories
                      .map(
                        (e) =>
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: CategoryItem(
                            category: e,
                            onTap: () => bloc.add(SingleGameStartRound(e)),
                          ),
                        ),
                  )
                      .toList(),
                );
              }),
        ),
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
    return <Widget>[];
  }

  void _skipWord(BuildContext context) {
    bloc.add(SingleGameUpdateWord(false));
  }

  void _yesWord(BuildContext context) {
    bloc.add(SingleGameUpdateWord(true));
  }
}
