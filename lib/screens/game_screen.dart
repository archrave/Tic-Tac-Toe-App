import 'dart:io';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/helper_widgets.dart';
import '../widgets/griditem.dart';
import '../widgets/gameover_menu.dart';
import '../widgets/decoration.dart';
import './rules_screen.dart';

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
              return const ExitGameDialog(
                title: 'Quit Game',
                content: 'Are you sure you want to exit the game?',
              );
            }) ??
        false;
  }

  Future<void> _exitToMenu() async {
    final doExit = await showDialog(
            context: context,
            builder: (context) {
              return const ExitGameDialog(
                title: 'Exit Game',
                content: 'Are you sure you want to quit to main menu?',
              );
            }) ??
        false;
    if (doExit) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _exitToHomeScreen() async {
    final doExit = await showDialog(
            context: context,
            builder: (context) {
              return const ExitGameDialog(
                title: 'Quit Game',
                content: 'Are you sure you want to exit the game?',
              );
            }) ??
        false;
    if (doExit) {
      exit(0);
    }
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
              'You sure you want to restart?',
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
  var _playerName = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playerName = ModalRoute.of(context)!.settings.arguments as String;
  }

  // Helper function to count the remaining spaces, so that the computer can mark its turn on one of these.
  void _countAvailbleSpaces() {
    _availableSpaces = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == ButtonMarker.available) {
        _availableSpaces.add(i);
      }
    }
  }

  int _countAvailbleSpacesBTS() {
    int count = 0;
    for (int i = 0; i < 9; i++) {
      if (board[i] == ButtonMarker.available) {
        count++;
      }
    }
    return count;
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
    _computersBestMove();
    // ************** CODE TO CHOOSE A RANDOM MOVE *********************

    // _countAvailbleSpaces();
    // dev.log('Available Spaces: $_availableSpaces');
    // if (_availableSpaces.isEmpty) return;
    // Random random = Random();
    // int randomNumber = random.nextInt(_availableSpaces.length);
    // dev.log('randomNumber = $randomNumber');
    // setState(() {
    //   board[_availableSpaces[randomNumber]] = ButtonMarker.computer;
    // });
    // dev.log('Computer marked O on ${_availableSpaces[randomNumber]}\n');
    _checkWinner();
  }

  void _checkWinner() {
    _countAvailbleSpaces();
    dev.log(_availableSpaces.toString());
    dev.log(board.toString());
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
      dev.log('##########        Available spaces = $_availableSpaces');
      _announceWinner(ButtonMarker.available);
    }
  }

  String? _checkWinnerBTS() {
    int totalAvailableSpaces = _countAvailbleSpacesBTS();

    // If the avaiable spaces are more than four, i.e, if the total turns yet are less than 5, there possibly cannot be a winner yet.
    if (totalAvailableSpaces > 4) {
      return null;
    }
    // Asking to announce a draw
    else if (checkRow(0)) {
      return board[0].toString();
    } else if (checkRow(3)) {
      return board[3].toString();
    } else if (checkRow(6)) {
      return board[6].toString();
    } else if (checkColumn(0)) {
      return board[0].toString();
    } else if (checkColumn(1)) {
      return board[1].toString();
    } else if (checkColumn(2)) {
      return board[2].toString();
    }
    // Checking for Diagonal 1
    else if (board[0] == board[4] && board[4] == board[8]) {
      return board[0].toString();
    }
    //Checking for Diagonal 2
    else if (board[2] == board[4] && board[4] == board[6]) {
      return board[2].toString();
    } else if (totalAvailableSpaces == 0) {
      return 'ButtonMarker.available';
    } else {
      return null;
    }
  }

// Annouces the winner
  void _announceWinner(ButtonMarker marker) async {
    if (marker == ButtonMarker.available) {
      _winnerMessage = 'Draw!';
    } else if (marker == ButtonMarker.player) {
      _winnerMessage = '$_playerName Wins!';
    } else {
      _winnerMessage = 'Computer Wins!';
    }
    dev.log('\n *************** $_winnerMessage ***************\n');
    await Future.delayed(const Duration(milliseconds: 300));
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
    setState(() {
      _isMatchFinished = false;
    });
    board = [];
    _availableSpaces = [];
    for (int i = 0; i < 9; i++) {
      board.add(ButtonMarker.available);
      _availableSpaces.add(i);
    }
  }

  void _computersBestMove() {
    var bestScore = -100;
    var move;
    for (int i = 0; i < 9; i++) {
      // Is the spot available
      if (board[i] == ButtonMarker.available) {
        board[i] = ButtonMarker.computer;
        var score = miniMax(board, 0, false);
        //Undoing the move so as to not change the global value of the board
        board[i] = ButtonMarker.available;
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    setState(() {
      if (move != null) {
        board[move] = ButtonMarker.computer;
        dev.log('Computer marked O on $move\n');
      }
    });
  }

  Map<String, int> scores = {
    'ButtonMarker.player': -1,
    'ButtonMarker.computer': 1,
    'ButtonMarker.available': 0,
  };

  int miniMax(List boardCopy, int depth, bool isMaximizing) {
    String? winner = _checkWinnerBTS();
    if (winner != null) {
      return scores[winner]!;
    }
    if (isMaximizing) {
      var bestScore = -100;
      for (int i = 0; i < 9; i++) {
        if (boardCopy[i] == ButtonMarker.available) {
          boardCopy[i] = ButtonMarker.computer;
          var score = miniMax(boardCopy, depth + 1, false);
          boardCopy[i] = ButtonMarker.available;
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      var bestScore = 100;
      for (int i = 0; i < 9; i++) {
        if (boardCopy[i] == ButtonMarker.available) {
          boardCopy[i] = ButtonMarker.player;
          var score = miniMax(boardCopy, depth + 1, true);
          boardCopy[i] = ButtonMarker.available;
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
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
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              ...XODecoration().gameDecoratedItems,
              Container(
                padding: const EdgeInsets.all(20),
                child: !_isMatchFinished
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: _exitToMenu,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, RulesScreen.routeName),
                                icon: Icon(
                                  FontAwesomeIcons.question,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: PlayerVsComputer(playerName: _playerName),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints: const BoxConstraints(
                                      maxWidth: 500, maxHeight: 500),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: _deviceWidth - 60,
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(0),
                                      semanticChildCount: 9,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            1 / 3 * (_deviceWidth),
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
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DarkIconButton(
                                    onPressed: _restartGame,
                                    icon: const Icon(FontAwesomeIcons.redo),
                                    size: 80,
                                  ),
                                  DarkIconButton(
                                    onPressed: _exitToMenu,
                                    icon: const Icon(Icons.home),
                                    size: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : GameOverMenu(
                        winnerMessage: _winnerMessage,
                        deviceWidth: _deviceWidth,
                        resetBoard: _resetBoard,
                        exitToMainMenu: _exitToMenu,
                        exitToHomeScreen: _exitToHomeScreen,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
