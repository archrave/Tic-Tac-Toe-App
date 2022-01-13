import 'package:flutter/material.dart';

enum ButtonMarker { player, computer, available }

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.width = 0,
    this.height = 0,
    required this.child,
    required this.onPressed,
    this.borderRadius = 8.0,
  });

  final double width;
  final double height;
  final Widget child;
  final VoidCallback? onPressed;
  final double borderRadius;

  final color1 = const Color(0xFF335BF9);
  final color2 = const Color(0xFF379BF3);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (height == 0 && width == 0) ? null : width,
      height: (height == 0 && width == 0) ? null : height,
      decoration: onPressed != null
          ? BoxDecoration(
              gradient:
                  //  onPressed != null?
                  LinearGradient(
                colors: [
                  color1,
                  color2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // : null,

              borderRadius: BorderRadius.circular(borderRadius),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
      child: ElevatedButton(
        style: (height == 0 && width == 0)
            ? ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                fixedSize: MaterialStateProperty.all(Size(width, height)),
              )
            : ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

class HorizontalLines extends StatelessWidget {
  const HorizontalLines({
    Key? key,
    required double deviceWidth,
  })  : _deviceWidth = deviceWidth,
        super(key: key);

  final double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // left: 1 / 3 * (_deviceWidth - 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ((_deviceWidth - 40) / 3)),
          Container(
            width: _deviceWidth - 40,
            height: 2,
            color: Colors.black.withOpacity(0.2),
          ),
          SizedBox(height: ((_deviceWidth - 40) / 3) - 2.5),
          Container(
            width: _deviceWidth - 40,
            height: 2,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}

class VerticalLines extends StatelessWidget {
  const VerticalLines({
    Key? key,
    required double deviceWidth,
  })  : _deviceWidth = deviceWidth,
        super(key: key);

  final double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // right: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: _deviceWidth - 40,
            width: 2,
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            height: _deviceWidth - 40,
            width: 2,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}

class ExitGameDialog extends StatelessWidget {
  const ExitGameDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).primaryTextTheme.headline2,
      ),
      content: Text(
        content,
        style: Theme.of(context)
            .primaryTextTheme
            .bodyText2!
            .copyWith(fontSize: 14),
      ),
      actions: [
        ElevatedButton(
          child: const Text('YES'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child: const Text('NO'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}

class PlayerVsComputer extends StatelessWidget {
  const PlayerVsComputer({
    Key? key,
    required String playerName,
  })  : _playerName = playerName,
        super(key: key);

  final String _playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                _playerName,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline2!
                    .copyWith(color: Colors.blueAccent),
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
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline2!
                    .copyWith(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
