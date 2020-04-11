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
      child: ListTile(
        leading: const Icon(Icons.games),
        title: Text("${game.players} players"),
        subtitle: Text(
          "Last updated ${game.lastUpdate} ",
        ),
      ),
    );
  }
}
