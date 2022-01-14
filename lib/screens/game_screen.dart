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
