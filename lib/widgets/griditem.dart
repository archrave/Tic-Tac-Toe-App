import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  GridItem({
    required this.index,
    // required this.buttonSelected,
  });

  final int index;
  // void Function? buttonSelected();

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isFilled = false;

  String filledBy = '';

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      margin: const EdgeInsets.all(5.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: filledBy == 'Player'
          ? Icon(Icons.close,
              size: 70 / 393 * _deviceWidth, color: Colors.green)
          : (filledBy == 'Computer'
              ? Icon(Icons.circle_outlined,
                  size: 70 / 393 * _deviceWidth, color: Colors.red)
              : InkWell(
                  child: Text('box ${widget.index}'),
                  onTap: () {},
                )),
    );
  }
}
