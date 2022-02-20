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

  void restartGameAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Restart The Game.'),
        content: const Text('Are you sure you want to restart the game?'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
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

  roundResultsSaver() {
    Map<int, List<int>> gameResults = {
      numberRounds: [
        _opponentDice,
        _userDice,
      ]
    };
    gameHistory.addAll(gameResults);
    return gameHistory;
  }

  historyDrawer(op, us) {
    return SizedBox(
        width: 70,
        height: 25,
        child: (() {
          if (op > us) {
            return Container(
                padding: EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Lose.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ));
          }
          if (op < us) {
            return Container(
                padding: EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Win.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ));
          } else {
            return Container(
                padding: EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Draw.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ));
          }
        }()));
  }

  showRoundHistory() {
    gameHistory.containsKey(0)
        ? gameHistory.clear()
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                backgroundColor: Colors.black45,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage('images/dicelogo.png'),
                            size: 40,
                            color: Colors.white70,
                          ),
                          Padding(padding: EdgeInsets.all(4)),
                          Text(
                            'Round History: ',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          ImageIcon(
                            AssetImage('images/dicelogo.png'),
                            size: 40,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      if (gameHistory.isEmpty)
                        Column(
                          children: [
                            Text(
                              'Game history is empty.',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 25),
                            ),
                            Padding(padding: EdgeInsets.all(10))
                          ],
                        )
                      else
                        for (var k in gameHistory.keys)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: 230,
                              height: 25,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      child: SizedBox(
                                        width: 70,
                                        height: 25,
                                        child: Center(
                                          child: Text(
                                            'Round ' + k.toString() + ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.blueAccent,
                                        ),
                                        child: Text(
                                          gameHistory[k]![0].toString() +
                                              ' : ' +
                                              gameHistory[k]![1].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(4)),
                                    historyDrawer(
                                        gameHistory[k]![0], gameHistory[k]![1])
                                  ],
                                ),
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
      roundResultsSaver();
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
              child: FloatingActionButton(
                elevation: 20,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                child: ImageIcon(
                  AssetImage('images/dicelogo.png'),
                  size: 40,
                ),
                onPressed: showRoundHistory,
              ))
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blueAccent,
                Colors.orangeAccent,
              ],
            ),
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
                  displayWitchRound(),
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
