import 'package:flutter/material.dart';
import 'package:flutter_word_guesser/blocs/singleplayerbloc.dart';

import '../messages.dart';

class PlayerName extends StatelessWidget {
  final SinglePlayerState playerState;
  final TextStyle style;

  PlayerName({@required this.playerState, this.style});

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (playerState is SinglePlayerUninitialized ||
        playerState is SinglePlayerDeleted) {
      widget = Text(Messages.of(context).unknown, style: style);
    }

    if (playerState is SinglePlayerLoaded) {
      widget = Text(playerState.player.name, style: style);
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: widget,
    );
  }
}
