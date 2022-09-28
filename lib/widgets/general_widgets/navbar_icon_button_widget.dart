import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class NavbarIconButtonWidget extends StatefulWidget {
  const NavbarIconButtonWidget({
    Key? key,
    required this.onPressedFunction,
    required this.iconData,
    required this.index,
    required this.selectedItem,
    required this.menuAndIcon,
  }) : super(key: key);

  final Function onPressedFunction;
  final List<IconData> iconData;
  final Map<String,IconData> menuAndIcon;
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
          Column(
            children: [
              Icon(
                widget.menuAndIcon.values.elementAt(widget.index),
                size: 26,
                color: Styles.hiGymText,
              ),
              Text(widget.menuAndIcon.keys.elementAt(widget.index), style: Styles.navBarMenuText,),
            ],
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