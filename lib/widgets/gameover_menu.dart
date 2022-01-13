import 'package:flutter/material.dart';
import './helper_widgets.dart';

class GameOverMenu extends StatelessWidget {
  const GameOverMenu({
    Key? key,
    required this.winnerMessage,
    required this.deviceWidth,
    required this.resetBoard,
  }) : super(key: key);

  final String winnerMessage;
  final double deviceWidth;
  final VoidCallback? resetBoard;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(winnerMessage,
              style: Theme.of(context).primaryTextTheme.headline1),
          const SizedBox(height: 20),
          CustomButton(
            width: 200 / 393 * deviceWidth,
            height: 50,
            child: Text(
              'Restart Game',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            onPressed: resetBoard,
          ),
          const SizedBox(height: 20),
          CustomButton(
              width: 200 / 393 * deviceWidth,
              height: 50,
              child: Text(
                'Main Menu',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline2!
                    .copyWith(color: Colors.white),
              ),
              onPressed: () async {
                final doExit = await showDialog(
                        context: context,
                        builder: (context) {
                          return const ExitGameDialog(
                            title: 'Exit Game',
                            content:
                                'Are you sure you want to quit to main menu?',
                          );
                        }) ??
                    false;
                if (doExit) {
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
    );
  }
}
