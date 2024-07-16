import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_page_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 1st player is O
  bool oTurn = true;

  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomePageHelper.buildScoreBoardItem(
                  teamName: 'Team X',
                  teamScore: xScore,
                ),
                HomePageHelper.buildScoreBoardItem(
                  teamName: 'Team O',
                  teamScore: oScore,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => _onTapped(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            displayElement[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        HomePageHelper.buildClearScoreBoardButton(
          context: context,
          clearScoreBoard: _clearScoreBoard,
        ),
      ],
    );
  }

  void _onTapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
        oTurn = false;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
        oTurn = true;
      }

      _checkWinner.call();
    });
  }

  void _checkWinner() {
    /// Checking rows
    if (displayElement[0] != '' &&
        displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2]) {
      _showWinDialog.call(displayElement[0]);
    }
    if (displayElement[3] != '' &&
        displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5]) {
      _showWinDialog.call(displayElement[3]);
    }
    if (displayElement[6] != '' &&
        displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8]) {
      _showWinDialog.call(displayElement[6]);
    }

    /// Checking Column
    if (displayElement[0] != '' &&
        displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6]) {
      _showWinDialog.call(displayElement[0]);
    }
    if (displayElement[1] != '' &&
        displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7]) {
      _showWinDialog.call(displayElement[1]);
    }
    if (displayElement[2] != '' &&
        displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8]) {
      _showWinDialog.call(displayElement[2]);
    }

    /// Checking Diagonal
    if (displayElement[0] != '' &&
        displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8]) {
      _showWinDialog.call(displayElement[0]);
    }
    if (displayElement[2] != '' &&
        displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6]) {
      _showWinDialog.call(displayElement[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog.call();
    }
  }

  void _showWinDialog(String winner) {
    winner == 'O' ? oScore++ : xScore++;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            title: Text(
              'Congratulations !!!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: MediaQuery.sizeOf(context).width * 0.08,
              ),
            ),
            content: Text(
              "\" $winner \" is Winner!!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: MediaQuery.sizeOf(context).width * 0.05,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            title: Text(
              "Draw",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: MediaQuery.sizeOf(context).width * 0.05,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      filledBoxes = 0;
    });
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < displayElement.length; i++) {
        displayElement[i] = '';
      }
      filledBoxes = 0;
    });
  }
}
