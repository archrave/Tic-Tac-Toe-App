import 'package:flutter/material.dart';

import '/screens/game_screen.dart';
import '../widgets/helper_widgets.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';

  const WelcomeScreen({
    required this.playerName,
  });

  final String? playerName;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // String widget.playerName = '';
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   widget.playerName = ModalRoute.of(context)!.settings.arguments as String;
  // }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                'Welcome to Tic Tac Toe!',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
          ),
          const SizedBox(height: 100),
          CustomButton(
              width: 200 / 393 * _deviceWidth,
              height: 55,
              borderRadius: 50,
              child: Text(
                'Play',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(GameScreen.routeName,
                    arguments: widget.playerName);
              }),
        ],
      ),
    );
  }
}
