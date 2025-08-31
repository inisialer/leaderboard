import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class PointRuleTile extends StatelessWidget {
  final String title;
  final String pointText;
  final Color pointColor;

  const PointRuleTile({
    super.key,
    required this.title,
    required this.pointText,
    required this.pointColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: black14w400),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: pointColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              pointText,
              style: GoogleFonts.rubik(color: pointColor, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
