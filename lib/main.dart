import 'package:flutter/material.dart';
import 'dice.dart';

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
      home: const MyHomePage(
        title: 'Flutter Dice Game',
      ),
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
  int _userDice = 0;
  int _opponentDice = 0;
  int userScore = 0;
  int opponentScore = 0;
  int numberRounds = 0;
  Map<int, List<int>> gameHistory = {
    0: [
      0,
      0,
    ]
  };

  void startNewRound() {
    numberRounds++;
    if (_opponentDice > _userDice) {
      opponentScore++;
    } else {
      if (_opponentDice < _userDice) {
        userScore++;
      }
    }
  }

//in progress 01.02.2022
  void restartGameAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Restart The Game.'),
        content: const Text('Are you sure you want to restart the game?'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        // shape: CircleBorder(side: BorderSide.none),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel!'),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              restartGame();
              Navigator.pop(context);
            },
            child: const Text('Yes!'),
          ),
        ],
      ),
    );
  }

  void restartGame() {
    setState(() {
      userScore = 0;
      opponentScore = 0;
      numberRounds = 0;
      _userDice = 0;
      _opponentDice = 0;
      gameHistory.clear();
      Dice.whoWon(_userDice, _opponentDice);
    });
  }

  rundResultsSaver() {
    Map<int, List<int>> gameResults = {
      numberRounds: [
        _opponentDice,
        _userDice,
      ]
    };
    gameHistory.addAll(gameResults);
    return gameHistory;
  }

  showRoundHistory1() {
    gameHistory.forEach((key, value) {
      Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(gameHistory[key].toString()),
          Text(':'),
          Text(gameHistory[key].toString())
        ]),
      );
    });
  }

  showRoundHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            child: Dialog(
                child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(gameHistory[0]![0].toString()),
              Text(':'),
              Text(gameHistory[0]![1].toString())
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(gameHistory[1]![0].toString()),
              Text(':'),
              Text(gameHistory[1]![1].toString())
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(gameHistory[2]![0].toString()),
              Text(':'),
              Text(gameHistory[2]![1].toString())
            ])
          ],
        )));
      },
    );
  }

  displayWitchRound() {
    if (numberRounds == 0) {
      return const Text(
        "We're starting the game!",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        'Round: $numberRounds',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      );
    }
  }

  roundStart() {
    setState(() {
      _userDice = Dice.throwDice();
      _opponentDice = Dice.throwDice();
      startNewRound();
      rundResultsSaver();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: const ImageIcon(
              AssetImage('images/dicelogo.png'),
              size: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: AlignmentDirectional(0, 10),
              image: AssetImage('images/diceimage.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Dice.whoWon(_userDice, _opponentDice),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Opponent result:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(
                            '$opponentScore',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 55),
                          ),
                          SizedBox(
                            child: Image.asset(
                                Dice.dropDiceImage('bot', _opponentDice)),
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
                            '$userScore',
                            // style: Theme.of(context).textTheme.headline1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 55),
                          ),
                          SizedBox(
                            child: Image.asset(
                                Dice.dropDiceImage('user', _userDice)),
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
                      style: ElevatedButton.styleFrom(
                        side:
                            BorderSide(color: Colors.lightBlueAccent, width: 1),
                      ),
                      onPressed: showRoundHistory,
                      child: const Text('History.'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side:
                            BorderSide(color: Colors.lightBlueAccent, width: 1),
                      ),
                      onPressed: roundStart,
                      child: numberRounds == 0
                          ? const Text('Start the game.')
                          : const Text('Start next round.'),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: restartGameAlert, // to do
                      child: const Text('Restart the game.'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          side:
                              BorderSide(color: Colors.orangeAccent, width: 1)),
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
      ),
    );
  }
}
