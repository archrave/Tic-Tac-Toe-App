import 'package:flutter/material.dart';

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
