import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/griditem.dart';
import '../widgets/helper_widgets.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/game-screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Future<bool> _onBackButtonPressed() async {
    return await showDialog(
            context: context,
            builder: (context) {
              return const ExitGameDialog();
            }) ??
        false;
  }

  void _buttonSelected() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                              style:
                                  Theme.of(context).primaryTextTheme.headline2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            'VS',
                            style: Theme.of(context).primaryTextTheme.bodyText2,
                          ),
                          Expanded(
                            child: Text(
                              'Computer',
                              style:
                                  Theme.of(context).primaryTextTheme.headline2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Stack(children: [
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
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 1 / 3 * (_deviceWidth),
                          // maxCrossAxisExtent: 353 / 3,
                        ),
                        itemCount: 9,
                        itemBuilder: (ctx, i) {
                          return GridItem(index: i);
                        }),
                  ),
                  VerticalLines(deviceWidth: _deviceWidth),
                  HorizontalLines(deviceWidth: _deviceWidth)
                ]),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
