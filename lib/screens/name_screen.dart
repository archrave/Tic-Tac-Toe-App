import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/screens/welcome_screen.dart';
import '../widgets/decoration.dart';
import '../widgets/helper_widgets.dart';

class NameScreen extends StatefulWidget {
  static const routeName = '/name-screen';

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String _playerName = '';

  final TextEditingController? _nameController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();

  void _submitName() async {
    if (!_nameFormKey.currentState!.validate()) {
      return;
    }
    _playerName = _nameController!.text;
    var _sharedprefs = await SharedPreferences.getInstance();
    _sharedprefs.setString('player_name', _playerName);
    log('hi just before navigator');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext ctx) => WelcomeScreen(
          playerName: _playerName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          ...XODecoration().decoratedItems,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Hi there, What should we call you?',
                    style: Theme.of(context).primaryTextTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Form(
                          key: _nameFormKey,
                          child: TextFormField(
                              controller: _nameController,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.black.withOpacity(0.8),
                                    letterSpacing: 1,
                                  ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey.withOpacity(0.4),
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey.withOpacity(0.4),
                                  ),
                                ),
                                focusColor: Theme.of(context).primaryColor,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                hintText: 'Your Name',
                                hintStyle: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name';
                                } else
                                  return null;
                              }),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
                          width: 100 / 393 * _deviceWidth,
                          height: 55,
                          borderRadius: 50,
                          child: const Icon(Icons.arrow_forward),
                          onPressed: _submitName,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
