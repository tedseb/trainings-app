import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class NavbarIconButtonWidget extends StatefulWidget {
  const NavbarIconButtonWidget({
    Key? key,
    required this.onPressedFunction,
    required this.iconData,
    required this.index,
    required this.selectedItem,
  }) : super(key: key);

  final Function onPressedFunction;
  final List<IconData> iconData;
  final int index;
  final int selectedItem;

  @override
  State<NavbarIconButtonWidget> createState() => _NavbarIconButtonWidgetState();
}

class _NavbarIconButtonWidgetState extends State<NavbarIconButtonWidget> {
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressedFunction(widget.index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.iconData[widget.index],
            size: 26,
            color: Styles.gymyGrey,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(
              top: widget.index == widget.selectedItem ? 2 : 0,
              right: 16,
              left: 16,
            ),
            width: 20.0,
            height: widget.index == widget.selectedItem ? 2 : 0,
            decoration: BoxDecoration(
              color: Styles.primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
