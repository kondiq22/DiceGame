import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatelessWidget {
  const Dice({Key? key}) : super(key: key);

  static throwDice() {
    int result = 1 + Random().nextInt(6);
    return result;
  }

  static whoWon(_userDice, _opponentDice) {
    int _option = 0;
    Map _textOptions = {
      0: 'Draw!',
      1: 'You Won!',
      2: 'You Lost!',
      3: 'Get Luck!',
    };

    if (_userDice != 0) {
      if (_userDice > _opponentDice) {
        _option = 1;
      } else {
        if (_userDice < _opponentDice) {
          _option = 2;
        } else {
          _option = 0;
        }
      }
    } else {
      _option = 3;
    }
    return Text(
      _textOptions[_option],
      style: TextStyle(
        fontSize: 55,
        fontWeight: FontWeight.bold,
        color: setTextColor(_option),
      ),
    );
  }

  static setTextColor(_option) {
    switch (_option) {
      case 1:
        {
          return Colors.green;
        }

      case 2:
        {
          return Colors.red;
        }

      default:
        {
          return Colors.blueAccent;
        }
    }
  }

  static dropDiceImage(String whoDice, int result) {
    Map<String, List<String>> _diceImage = {
      'bot': [
        'images/b0.png',
        'images/b1.png',
        'images/b2.png',
        'images/b3.png',
        'images/b4.png',
        'images/b5.png',
        'images/b6.png',
      ],
      'user': [
        'images/u0.png',
        'images/u1.png',
        'images/u2.png',
        'images/u3.png',
        'images/u4.png',
        'images/u5.png',
        'images/u6.png',
      ],
    };
    return _diceImage[whoDice]![result];
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

