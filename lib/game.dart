import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  Game(this.userScore, this.opponentScore, this.numberRounds, {Key? key})
      : super(key: key);
  int userScore = 0;
  int opponentScore = 0;
  int numberRounds = 0;

  void startNewRound(numberRounds, _opponentDice, _userDice) {
    numberRounds++;
    if (_opponentDice > _userDice) {
      opponentScore++;
    } else {
      if (_opponentDice < _userDice) {
        userScore++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
