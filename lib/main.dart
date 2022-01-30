import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Dice Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _dice = 0;
  int _opponentDice = 0;

  throwDice() {
    int result = 1 + Random().nextInt(6);
    return result;
  }

  roundStart() {
    setState(() {
      _dice = throwDice();
      _opponentDice = throwDice();
    });
  }

  whoWon(_dice, _opponentDice) {
    int _option = 0;
    Map _textOptions = {
      0: 'Draw!',
      1: 'You Won!',
      2: 'You Lost!',
      3: 'Get Luck!',
    };
    if (_dice != 0) {
      if (_dice > _opponentDice) {
        _option = 1;
      } else {
        if (_dice < _opponentDice) {
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

  setTextColor(_option) {
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

  dropDiceImage(String whoDice, int result) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                whoWon(_dice, _opponentDice),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Opponent result:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          '$_opponentDice',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 55),
                        ),
                        SizedBox(
                          child:
                              Image.asset(dropDiceImage('bot', _opponentDice)),
                          width: 140,
                          height: 140,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Your result: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          '$_dice',
                          // style: Theme.of(context).textTheme.headline1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 55),
                        ),
                        SizedBox(
                          child: Image.asset(dropDiceImage('user', _dice)),
                          width: 140,
                          height: 140,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: roundStart,
                    child: const Text('Start the game.'),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: roundStart, // to do
                    child: const Text('Restart the game.'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
