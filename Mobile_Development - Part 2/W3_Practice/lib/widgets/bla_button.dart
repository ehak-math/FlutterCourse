import 'package:flutter/material.dart';
import '../theme/theme.dart';

enum BlaButtonType { primary, secondary}

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;

  const BlaButton(
    {super.key, 
    required this.text,
    this.onPressed,
    this.type = BlaButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        iconColor: type == BlaButtonType.primary ? BlaColors.white : BlaColors.primary,
        backgroundColor: type == BlaButtonType.primary ? BlaColors.backGroundColor : BlaColors.white,
        foregroundColor: type == BlaButtonType.primary ? BlaColors.white : BlaColors.primary,
        side: BorderSide(
          color: type == BlaButtonType.primary ? BlaColors.primary : BlaColors.disabled,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
