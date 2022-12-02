import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class NavbarIconButtonWidget extends StatefulWidget {
  const NavbarIconButtonWidget({
    Key? key,
    required this.onPressedFunction,
    required this.iconData,
    this.iconText,
    required this.selectedItem,
    required this.index,
    this.borderHeigth = 2.0,
    this.borderWidth = 20.0,

  }) : super(key: key);

  final Function onPressedFunction;
  final IconData iconData;
  final String? iconText;
  final int selectedItem;
  final int index;
  final double borderHeigth;
  final double borderWidth;

  @override
  State<NavbarIconButtonWidget> createState() => _NavbarIconButtonWidgetState();
}

class _NavbarIconButtonWidgetState extends State<NavbarIconButtonWidget> {
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressedFunction(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                widget.iconData,
                size: 26,
                color: Styles.darkGrey,
              ),
              widget.iconText != null ? Text(widget.iconText! , style: Styles.tinyLinesBold,) : const SizedBox(),
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
            width: widget.borderWidth,
            height: widget.index == widget.selectedItem ? widget.borderHeigth : 0,
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
