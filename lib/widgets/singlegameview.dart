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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/categorybloc.dart';
import 'package:flutter_word_guesser/blocs/singlegamebloc.dart';
import 'package:flutter_word_guesser/widgets/countdownwidget.dart';
import 'package:flutter_word_guesser/widgets/playername.dart';

import '../messages.dart';
import 'categoryitem.dart';
import 'playernameuid.dart';

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
      if (g.round.endTime.isBefore(DateTime.now())) {
        bloc.add(
          SingleGameUpdate(game: g.rebuild((b) => b..round.completed = true)),
        );
      }
      if (g.round.currentPlayerUid == myUid) {
        if (!gameState.loadedCategory) {
          bloc.add(SingleGameLoadCategory());
        }
        // Show a button bar with the skip/yes on it.
        return Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text("Guessing word",
                  style: Theme.of(context).textTheme.headline2),
              Container(
                alignment: Alignment.center,
                child: CountdownWidget(
                    endTime: g.round.endTime,
                    style: Theme.of(context).textTheme.headline1),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("SKIP",
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    color: Theme.of(context).buttonTheme.colorScheme.background,
                    onPressed: () => _skipWord(context),
                  ),
                  SizedBox(width: 50),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("YES",
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    color: Theme.of(context).buttonTheme.colorScheme.background,
                    onPressed: () => _yesWord(context),
                  )
                ],
              ),
            ],
          ),
        );
      } else {
        // Show everyone the word to guess.
        return Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Word to guess",
                  style: Theme.of(context).textTheme.headline2),
              Container(
                alignment: Alignment.center,
                child: CountdownWidget(
                    endTime: g.round.endTime,
                    style: Theme.of(context).textTheme.headline1),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(g.round.words.last.word,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Theme.of(context).accentColor)),
              ),
            ],
          ),
        );
      }
    }
    if (!gameState.game.players.containsKey(myUid)) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _lastRound(context),
            ButtonBar(
              children: _getButtons(context),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _lastRound(context),
          ButtonBar(
            children: _getButtons(context),
          ),
          Divider(),
          Text(
            "Pick a Category",
            style: Theme.of(context).textTheme.headline6,
          ),
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
                          (e) => Padding(
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
      ),
    );
  }

  Widget _lastRound(BuildContext context) {
    if (gameState.game.round != null) {
      var success = gameState.game.round.words
          .where((e) => e.successful != null && e.successful)
          .map((e) => e.word)
          .join(", ");
      var failed = gameState.game.round.words
          .where((e) => e.successful == null || !e.successful)
          .map((e) => e.word)
          .join(", ");

      return Card(
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 20, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: "Last Round ",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 10),
              PlayerNameUid(
                playerUid: gameState.game.round.currentPlayerUid,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Theme.of(context).accentColor),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    text: "Successful: ",
                    children: [
                      TextSpan(
                        text: success.isEmpty ? "None" : success,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.green.shade800),
                      ),
                    ],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    text: "Failed: ",
                    children: [
                      TextSpan(
                        text: failed.isEmpty ? "None" : failed,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Theme.of(context).errorColor),
                      ),
                    ],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Text("No one currently playing",
        style: Theme.of(context).textTheme.headline5);
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
