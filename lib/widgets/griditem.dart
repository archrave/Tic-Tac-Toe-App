import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      margin: const EdgeInsets.all(6.0),
      color: Colors.white,
      child: widget.marker == ButtonMarker.player
          ? Container(
              child: SvgPicture.asset(
                'assets/images/X.svg',
                fit: BoxFit.scaleDown,
                width: 60,
                height: 60,
              ),
            )
          // ? Icon(Icons.close, size: 70 / 393 * _deviceWidth, color: Colors.blue)
          : (widget.marker == ButtonMarker.computer
              ? Container(
                  child: SvgPicture.asset(
                    'assets/images/O.svg',
                    fit: BoxFit.scaleDown,
                    width: 60,
                    height: 60,
                  ),
                )
              // Icon(Icons.circle_outlined,
              //     size: 70 / 393 * _deviceWidth, color: Colors.red)
              : InkWell(
                  child: const SizedBox.shrink(),
                  onTap: () {
                    widget.buttonSelected(widget.index);
                  },
                )),
    );
  }
}
