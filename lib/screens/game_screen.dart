import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/widgets/helper_widgets.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/game-screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool val = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text(
                    'Quit',
                    style: Theme.of(context).primaryTextTheme.headline2,
                  ),
                  content: Text(
                    'Are you sure you want to quit the game? Your progress will not be saved',
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  actions: [
                    CustomButton(
                        child: Text('YES'),
                        onPressed: () {
                          val = true;
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: Text('NO'),
                      onPressed: () {
                        val = false;
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
            });
        return val;
      },
      child: Scaffold(
        body: Center(
          child: Text('game'),
        ),
      ),
    );
  }
}
