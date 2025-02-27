import 'package:flutter/material.dart';

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
      icon: icon != null ? Icon(icon) : Container(),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        iconColor: isPrimary ? Colors.white : Colors.blue,
        backgroundColor: isPrimary ? Colors.blue : Colors.white,
        foregroundColor: isPrimary ? Colors.white : Colors.blue,
        side: BorderSide(
          color: isPrimary ? Colors.blue : Colors.grey[300]!,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
