import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/game_screen.dart';
import './screens/welcome_screen.dart';
import './screens/name_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // To check whether the user has previously entered their name or not
  Future<String?> _checkNameStorage() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('player_name') != null) {
      log('\nWe have this name: ${prefs.getString('player_name')}');
      return prefs.getString('player_name');
    } else {
      return null;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData.light().copyWith(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFC6EFF9),
        primaryColor: const Color(0xFF1D2571),
        errorColor: const Color(0xFFF35E67),
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xFF6B79F2),
          primaryVariant: const Color(0xFF2D3DCB),
          secondary: const Color(0xFFF35E67),
          secondaryVariant: const Color(0xFFBE101A),
        ),
        primaryTextTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            fontSize: 24,
            color: const Color(0xFF1D2571),
            fontWeight: FontWeight.w600,
          ),
          headline2: GoogleFonts.poppins(
            fontSize: 21,
            color: const Color(0xFF1D2571),
            fontWeight: FontWeight.w600,
          ),
          bodyText2: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xFF1D2571),
          ),
          bodyText1: GoogleFonts.poppins(
            fontSize: 20,
            color: const Color(0xFF1D2571),
          ),
        ),
      ),
      routes: {
        '/': (ctx) => FutureBuilder<String?>(
            future: _checkNameStorage(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                if (snapshot.hasData && snapshot.data != null) {
                  return WelcomeScreen(playerName: snapshot.data);
                } else {
                  return NameScreen();
                }
              } else {
                return const Scaffold(body: SizedBox());
              }
            }),

        // NameScreen.routeName: (ctx) => NameScreen(),
        // WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
        GameScreen.routeName: (ctx) => const GameScreen(),
      },
      debugShowCheckedModeBanner: false,
      // home: NameScreen(),
    );
  }
}
