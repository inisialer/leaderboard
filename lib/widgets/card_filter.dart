import 'package:flutter/material.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class CardDropdown extends StatelessWidget {
  const CardDropdown({super.key, required this.onTap, required this.title});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          spacing: 4,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: black14w400,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: blackColor,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
