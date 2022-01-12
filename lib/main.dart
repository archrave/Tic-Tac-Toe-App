import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/game_screen.dart';
import './screens/welcome_screen.dart';
import './screens/name_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: GoogleFonts.poppins(
            fontSize: 21,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          bodyText2: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
          bodyText1: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      routes: {
        NameScreen.routeName: (ctx) => NameScreen(),
        WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
        GameScreen.routeName: (ctx) => GameScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: NameScreen(),
    );
  }
}
