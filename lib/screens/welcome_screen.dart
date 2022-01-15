import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/decoration.dart';
import '/screens/game_screen.dart';
import '../widgets/helper_widgets.dart';
import './rules_screen.dart';
import './name_screen.dart';

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
  Future<bool> _onBackButtonPressed() async {
    return await showDialog(
            context: context,
            builder: (context) {
              return const ExitGameDialog(
                title: 'Exit Game',
                content: 'Are you sure you want to exit the game?',
              );
            }) ??
        false;
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              ...XODecoration().decoratedItems,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 30),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Ink(
                              width: 50,
                              height: 50,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(),
                                shadows: [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: PopupMenuButton(
                                  onSelected: (selectedValue) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Are you sure',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline2,
                                          ),
                                          content: Text(
                                            'Are you sure you want to change your entered name?',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText2!
                                                .copyWith(fontSize: 14),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text('YES'),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        NameScreen.routeName);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('NO'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Text(widget.playerName![0],
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1),
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                      child: Text(
                                        'Change Name',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText2!,
                                      ),
                                      value: 'Change Name',
                                    ),
                                  ],
                                ),
                              ),

                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Center(
                              // child: Text(widget.playerName![0],
                              //     style: Theme.of(context)
                              //         .primaryTextTheme
                              //         .headline1),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Welcome, ${widget.playerName}!',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline1!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              height: 60 / 393 * _deviceWidth,
                              width: 60 / 393 * _deviceWidth,
                              child:
                                  SvgPicture.asset('assets/images/big_x.svg'),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 60 / 393 * _deviceWidth,
                              width: 60 / 393 * _deviceWidth,
                              child:
                                  SvgPicture.asset('assets/images/big_o.svg'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          'TIC TAC TOE',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          width: 200 / 393 * _deviceWidth,
                          height: 55,
                          borderRadius: 50,
                          child: Text(
                            'Start Game',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                GameScreen.routeName,
                                arguments: widget.playerName);
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          isActive: false,
                          width: 200 / 393 * _deviceWidth,
                          height: 55,
                          borderRadius: 50,
                          child: Text(
                            'Rules',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, RulesScreen.routeName),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          isActive: false,
                          width: 200 / 393 * _deviceWidth,
                          height: 55,
                          borderRadius: 50,
                          child: Text(
                            'Quit Game',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline2!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                          ),
                          onPressed: () async {
                            // final doExit = await
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const ExitGameDialog(
                                  title: 'Quit Game',
                                  content: 'Are you sure you want to quit?',
                                  exitToHomeScreen: true,
                                );
                              },
                            );
                            //         ??
                            //     false;
                            // if (doExit) {
                            //   Navigator.of(context).pop();
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
