import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(widget.playerName![0],
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1),
                            ),
                          ),
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
                          child: SvgPicture.asset('assets/images/big_x.svg'),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 60 / 393 * _deviceWidth,
                          width: 60 / 393 * _deviceWidth,
                          child: SvgPicture.asset('assets/images/big_o.svg'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      'TIC TAC TOE',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 60,
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
                        Navigator.of(context).pushNamed(GameScreen.routeName,
                            arguments: widget.playerName);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      width: 200 / 393 * _deviceWidth,
                      height: 55,
                      borderRadius: 50,
                      child: Text(
                        'Rules',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      width: 200 / 393 * _deviceWidth,
                      height: 55,
                      borderRadius: 50,
                      child: Text(
                        'Quit Game',
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
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
