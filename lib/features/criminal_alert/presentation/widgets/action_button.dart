import 'package:flutter/material.dart';

class CriminalActionButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final int width;
  const CriminalActionButton({super.key,
  required this.label,
  required this.onPressed,
  required this.color,
  required this.textColor,
  this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: width.toDouble(),
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
