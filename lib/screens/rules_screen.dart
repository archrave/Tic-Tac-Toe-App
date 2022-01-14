import 'package:flutter/material.dart';
import '../widgets/decoration.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({Key? key}) : super(key: key);

  static const routeName = '/rules-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ...XODecoration().decoratedItems,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'RULES',
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                  const SizedBox(height: 30),
                  const RuleText(
                      text:
                          'Click on any empty box on the grid to mark it as yours.'),
                  const RuleText(
                      text:
                          'The first player to get 3 of theier marks in a row (up, down, across, or diagonally) is the winner.'),
                  const RuleText(
                      text:
                          'When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a draw.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RuleText extends StatelessWidget {
  const RuleText({required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '- $text',
        style: Theme.of(context).primaryTextTheme.bodyText1,
      ),
    );
  }
}
