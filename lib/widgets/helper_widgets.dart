import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

enum ButtonMarker { player, computer, available }

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.width = 0,
    this.height = 0,
    required this.child,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.isActive = true,
  });

  final double width;
  final double height;
  final Widget child;
  final VoidCallback? onPressed;
  final double borderRadius;
  final bool isActive;

  final color1 = const Color(0xFF6B79F2);
  final color2 = const Color(0xFF4351D8);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (height == 0 && width == 0) ? null : width,
      height: (height == 0 && width == 0) ? null : height,
      decoration: (onPressed != null)
          ? isActive
              ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color1,
                      color2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
    final double gridItemSize = (_deviceWidth - 80) / 3;
    return Positioned(
      left: 10,
      top: 10,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: gridItemSize - 2),
            Container(
              width: _deviceWidth - 80,
              height: 2,
              color: Colors.black.withOpacity(0.2),
            ),
            SizedBox(height: (gridItemSize) - 2),
            Container(
              width: _deviceWidth - 80,
              height: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
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
      child: Container(
        margin: const EdgeInsets.all(10),
        // color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: _deviceWidth - 80,
              width: 2,
              color: Colors.black.withOpacity(0.2),
            ),
            Container(
              height: _deviceWidth - 80,
              width: 2,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class ExitGameDialog extends StatelessWidget {
  const ExitGameDialog({
    Key? key,
    required this.title,
    required this.content,
    this.exitToHomeScreen = false,
  }) : super(key: key);

  final String title;
  final bool exitToHomeScreen;
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            if (!exitToHomeScreen) {
              return Navigator.of(context).pop(true);
            } else {
              exit(0);
            }
          },
        ),
        TextButton(
          child: const Text('NO'),
          onPressed: () => Navigator.of(context).pop(false),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor,
            ),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  _playerName,
                  style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'vs',
                  style: Theme.of(context).primaryTextTheme.headline1,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Computer',
                  style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DarkIconButton extends StatelessWidget {
  const DarkIconButton({
    required this.onPressed,
    required this.icon,
    required this.size,
  });

  final void Function()? onPressed;
  final Widget icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: 40,
        color: Colors.white,

        // splashColor: Colors.blueGrey,
      ),
    );
  }
}
