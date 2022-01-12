import 'package:flutter/material.dart';
import 'helper_widgets.dart';

class GridItem extends StatefulWidget {
  GridItem({
    required this.index,
    required this.buttonSelected,
    required this.marker,
  });

  final int index;
  final Function(int index) buttonSelected;
  ButtonMarker marker;

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      margin: const EdgeInsets.all(5.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: widget.marker == ButtonMarker.player
          ? Icon(Icons.close, size: 70 / 393 * _deviceWidth, color: Colors.blue)
          : (widget.marker == ButtonMarker.computer
              ? Icon(Icons.circle_outlined,
                  size: 70 / 393 * _deviceWidth, color: Colors.red)
              : InkWell(
                  child: const SizedBox.shrink(),
                  onTap: () {
                    widget.buttonSelected(widget.index);
                  },
                )),
    );
  }
}
