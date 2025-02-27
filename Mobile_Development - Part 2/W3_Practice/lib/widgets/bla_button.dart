import 'package:flutter/material.dart';
import '../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;

  const BlaButton(
    {super.key, 
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        iconColor: isPrimary ? BlaColors.white : BlaColors.primary,
        backgroundColor: isPrimary ? BlaColors.backGroundColor : BlaColors.white,
        foregroundColor: isPrimary ? BlaColors.white : BlaColors.primary,
        side: BorderSide(
          color: isPrimary ? BlaColors.primary : BlaColors.disabled,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
