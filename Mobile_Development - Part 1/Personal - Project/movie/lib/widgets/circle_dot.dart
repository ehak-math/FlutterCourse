import 'package:flutter/material.dart';

class CircleDot extends StatelessWidget {
  const CircleDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
