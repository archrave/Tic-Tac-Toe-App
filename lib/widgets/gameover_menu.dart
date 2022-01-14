import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/rules_screen.dart';
import './helper_widgets.dart';

class GameOverMenu extends StatelessWidget {
  const GameOverMenu({
    Key? key,
    required this.winnerMessage,
    required this.deviceWidth,
    required this.resetBoard,
    required this.exitToMainMenu,
    required this.exitToHomeScreen,
  }) : super(key: key);

  final String winnerMessage;
  final double deviceWidth;
  final VoidCallback? resetBoard;
  final Function()? exitToMainMenu;
  final Function()? exitToHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: exitToMainMenu,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      winnerMessage,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline1!
                          .copyWith(
                            fontSize: 32,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DarkIconButton(
                      onPressed: resetBoard,
                      icon: const Icon(FontAwesomeIcons.redo),
                      size: 80,
                    ),
                    DarkIconButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(RulesScreen.routeName),
                      icon: const Icon(FontAwesomeIcons.question),
                      size: 80,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DarkIconButton(
                      onPressed: exitToMainMenu,
                      icon: const Icon(Icons.home),
                      size: 80,
                    ),
                    DarkIconButton(
                      onPressed: exitToHomeScreen,
                      icon: const Icon(Icons.exit_to_app),
                      size: 80,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
