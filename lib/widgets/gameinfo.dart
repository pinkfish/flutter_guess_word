import 'package:flutter/material.dart';
import 'package:flutter_word_guesser/data/game.dart';

///
/// Shows the game information for this game
///
class GameInfo extends StatelessWidget {
  final Game game;
  final Animation<double> animation;

  GameInfo({@required this.game, this.animation});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: Padding(
        child: ListTile(
          leading: const Icon(Icons.games),
          onTap: () =>
              Navigator.popAndPushNamed(context, "Game/" + game.uid,
                  arguments: game.uid),
          title: Text(game.title),
          subtitle: Text(
            "Last updated ${game.lastUpdated.toDate()}, ${game.players
                .length} players ",
          ),
        ),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
