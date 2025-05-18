import 'package:flutter/material.dart';

import '../../configs/theme/app_colors.dart' show AppColors;

class ButtonWidget extends StatelessWidget {
  final Widget? content;
  final VoidCallback? onPressed;
  final double? width;
  final double? padding;
  final Color? color;
  final double? height;
  const ButtonWidget({
    super.key,
    required this.content,
    required this.onPressed,
    this.width,
    this.padding,
    this.height= 60,
    this.color = AppColors.primaryColor,
  });



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          letterSpacing: 1.2,
          fontFamily: 'Urbanist',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        minimumSize: Size(
          width ?? double.infinity,
          height?? 50,
        ),
        maximumSize: Size(
          width ?? double.infinity,
          height?? 50,
        ),
        foregroundColor: AppColors.backgroundColor,
        backgroundColor: color,
        padding: EdgeInsets.all(padding ?? 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: content,
    );
  }
}
