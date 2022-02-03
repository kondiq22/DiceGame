import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  Game(this.userScore, this.opponentScore, this.numerRounds, {Key? key})
      : super(key: key);
  int userScore = 0;
  int opponentScore = 0;
  int numerRounds = 0;

  void startNewRound() {

    numerRounds++;

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



