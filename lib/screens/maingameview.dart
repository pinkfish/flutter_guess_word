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
import 'package:flutter_word_guesser/blocs/singleplayerbloc.dart';
import 'package:flutter_word_guesser/widgets/gameinfo.dart';
import 'package:flutter_word_guesser/widgets/playername.dart';
import 'package:flutter_word_guesser/widgets/savingoverlay.dart';

import '../messages.dart';

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
        return SavingOverlay(
          saving: state is SinglePlayerSaving,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
                  child: PlayerName(
                    playerState: state,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("NEW"),
                      onPressed: () =>
                          BlocProvider.of<SinglePlayerBloc>(context).add(
                            SinglePlayerStartGame(),
                          ),
                    ),
                    FlatButton(
                      child: Text("JOIN"),
                      onPressed: () => _joinGame(context),
                    ),
                  ],
                ),
                Expanded(
                  child: state.games.length == 0
                      ? state.loadedGames
                      ? Text("Not joined any games",
                      style: Theme.of(context).textTheme.bodyText1)
                      : Text(Messages.of(context).loading,
                      style: Theme.of(context).textTheme.bodyText1)
                      : AnimatedList(
                    key: _listKey,
                    initialItemCount: state.games.length,
                    itemBuilder: (BuildContext cointext, int index,
                        Animation<double> animate) =>
                        GameInfo(
                          game: state.games[index],
                          animation: animate,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _joinGame(BuildContext context) async {
    String uid;

    uid = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                onChanged: (String str) => uid,
                decoration: new InputDecoration(
                    labelText: 'Game ID', hintText: 'eg. uid'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/Game/", arguments: uid);
              })
        ],
      ),
    );
  }
}
