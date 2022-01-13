import 'package:flutter/material.dart';
import '/screens/welcome_screen.dart';
import '../widgets/helper_widgets.dart';

class NameScreen extends StatefulWidget {
  static const routeName = '/name-screen';

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController? _nameController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();
  void _submitName() {
    if (!_nameFormKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName,
        arguments: _nameController!.text);
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
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
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
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
                CustomButton(
                    width: 100 / 393 * _deviceWidth,
                    height: 55,
                    borderRadius: 50,
                    child: const Icon(Icons.arrow_forward),
                    onPressed: _submitName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
