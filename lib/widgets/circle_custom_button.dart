import 'package:flutter/material.dart';

class CircleCustomButton extends StatelessWidget {
  const CircleCustomButton({
    super.key, this.onPressed, required this.icon, this.iconColor, this.backgroundColor, this.iconSize,
  });

  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: IconButton(
        onPressed: onPressed,
        icon:  Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(backgroundColor)),
      ),
    );
  }
}
