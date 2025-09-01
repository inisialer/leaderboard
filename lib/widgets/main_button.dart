import 'package:flutter/material.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.textStyle,
      this.width,
      this.onPressed});
  final String title;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? baseColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: textStyle ?? white14w400,
        ),
      ),
    );
  }
}
