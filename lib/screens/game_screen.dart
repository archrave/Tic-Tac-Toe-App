import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/griditem.dart';
import '../widgets/helper_widgets.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/game-screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Some display logic
  Future<bool> _onBackButtonPressed() async {
    return await showDialog(
            context: context,
            builder: (context) {
              return const ExitGameDialog();
            }) ??
        false;
  }

  void _restartGame() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Restart Game',
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
            content: Text(
              'You sure you wanna restart?',
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText2!
                  .copyWith(fontSize: 14),
            ),
            actions: [
              ElevatedButton(
                child: const Text('YES'),
                onPressed: () {
                  setState(() {
                    _resetBoard();
                    Navigator.of(context).pop();
                  });
                },
              ),
              TextButton(
                child: const Text('NO'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  //  In Game Logic functions begin here:

  List<ButtonMarker> board = [];
  List<int> _availableSpaces = [];
  bool _isMatchFinished = false;
  var _winnerMessage = '';

  // Helper function to count the remaining spaces, so that the computer can mark its turn on one of these.
  void _countAvailbleSpaces() {
    _availableSpaces = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == ButtonMarker.available) {
        _availableSpaces.add(i);
      }
    }
  }

// Runs when the player presses on an available space on the screen
  void _runPlayersTurn(int i) {
    setState(() {
      board[i] = ButtonMarker.player;
    });
    dev.log('Player marked X on $i\n');

    _checkWinner();
    if (_isMatchFinished) {
      return;
    }
    _runComputersTurn();
  }

//Runs after the player's turn
  void _runComputersTurn() {
    _countAvailbleSpaces();
    dev.log('Available Spaces: $_availableSpaces');
    if (_availableSpaces.isEmpty) return;
    Random random = Random();
    int randomNumber = random.nextInt(_availableSpaces.length);
    dev.log('randomNumber = $randomNumber');
    setState(() {
      board[_availableSpaces[randomNumber]] = ButtonMarker.computer;
    });
    dev.log('Computer marked O on ${_availableSpaces[randomNumber]}\n');
    _checkWinner();
  }

  void _checkWinner() {
    _countAvailbleSpaces();

    // If the avaiable spaces are more than four, i.e, if the total turns yet are less than 5, there possibly cannot be a winner yet.
    if (_availableSpaces.length > 4) {
      return;
    }
    // Asking to announce a draw
    else if (checkRow(0)) {
      _announceWinner(board[0]);
    } else if (checkRow(3)) {
      _announceWinner(board[3]);
    } else if (checkRow(6)) {
      _announceWinner(board[6]);
    } else if (checkColumn(0)) {
      _announceWinner(board[0]);
    } else if (checkColumn(1)) {
      _announceWinner(board[1]);
    } else if (checkColumn(2)) {
      _announceWinner(board[2]);
    }
    // Checking for Diagonal 1
    else if (board[0] == board[4] && board[4] == board[8]) {
      _announceWinner(board[0]);
    }
    //Checking for Diagonal 2
    else if (board[2] == board[4] && board[4] == board[6]) {
      _announceWinner(board[2]);
    } else if (_availableSpaces.isEmpty) {
      dev.log('######################Avialable spaces = $_availableSpaces');
      _announceWinner(ButtonMarker.available);
    }
  }

// Annouces the winner
  void _announceWinner(ButtonMarker marker) async {
    if (marker == ButtonMarker.available) {
      _winnerMessage = 'Draw!';
    } else if (marker == ButtonMarker.player) {
      _winnerMessage = 'Player Wins!';
    } else {
      _winnerMessage = 'Computer Wins';
    }
    dev.log('\n *************** $_winnerMessage ***************\n');
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _isMatchFinished = true;
    });
  }

  // Helper function to check if a row is entirely marked by anyone
  bool checkRow(int firstIndex) {
    return (board[firstIndex] == board[firstIndex + 1]) &&
        (board[firstIndex + 1] == board[firstIndex + 2]) &&
        (board[firstIndex] != ButtonMarker.available);
  }

  // Helper function to check if a column is entirely marked by anyone
  bool checkColumn(int firstIndex) {
    return (board[firstIndex] == board[firstIndex + 3]) &&
        (board[firstIndex + 3] == board[firstIndex + 6]) &&
        (board[firstIndex] != ButtonMarker.available);
  }

// Function to reset the game board.
  void _resetBoard() {
    _isMatchFinished = false;
    board = [];
    _availableSpaces = [];
    for (int i = 0; i < 9; i++) {
      board.add(ButtonMarker.available);
      _availableSpaces.add(i);
    }

    dev.log(board.toString());
  }

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: !_isMatchFinished
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  'Player',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                'VS',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2,
                              ),
                              Expanded(
                                child: Text(
                                  'Computer',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.red.withOpacity(0.4),
                          ),
                          height: _deviceWidth - 40,
                          child: GridView.builder(
                              padding: const EdgeInsets.all(0),
                              semanticChildCount: 9,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 1 / 3 * (_deviceWidth),
                                // maxCrossAxisExtent: 353 / 3,
                              ),
                              itemCount: 9,
                              itemBuilder: (ctx, i) {
                                return GridItem(
                                    index: i,
                                    marker: board[i],
                                    buttonSelected: _runPlayersTurn);
                              }),
                        ),
                        VerticalLines(deviceWidth: _deviceWidth),
                        HorizontalLines(deviceWidth: _deviceWidth)
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          CustomButton(
                            width: 100 / 393 * _deviceWidth,
                            height: 50,
                            child: Text(
                              'Restart',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: _restartGame,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_winnerMessage,
                          style: Theme.of(context).primaryTextTheme.headline1),
                      const SizedBox(height: 20),
                      CustomButton(
                          width: 200 / 393 * _deviceWidth,
                          height: 50,
                          child: Text(
                            'Restart Game',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: _restartGame),
                      const SizedBox(height: 20),
                      CustomButton(
                        width: 200 / 393 * _deviceWidth,
                        height: 50,
                        child: Text(
                          'Main Menu',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
