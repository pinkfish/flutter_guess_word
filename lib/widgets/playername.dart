import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/singleplayerbloc.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';

import '../messages.dart';

class PlayerName extends StatelessWidget {
  final SinglePlayerState playerState;

  PlayerName({@required this.playerState});

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (playerState is SinglePlayerUninitialized ||
        playerState is SinglePlayerDeleted) {
      widget = Text(Messages.of(context).unknown);
    }

    if (playerState is SinglePlayerLoaded) {
      widget = Text(playerState.player.name);
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: widget,
    );
  }
}
