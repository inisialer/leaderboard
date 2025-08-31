import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class CardWinner extends StatelessWidget {
  const CardWinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: darkPurpleColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/img_avatar1.png',
                  scale: 3,
                ),
                title: Text(
                  'Far East United',
                  style: black14w400,
                ),
                subtitle: Text(
                  'Surabaya',
                  style: semiBlack12w400,
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: baseColor, borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '50 Pts',
                    style: white9w800,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Komunitasmu peringkat ', style: white12w400),
                  TextSpan(text: '#456, ', style: white12w800),
                  TextSpan(text: 'bagikan yuk!', style: white12w400),
                ])),
                SvgPicture.asset('assets/icons/ic_share.svg')
              ],
            ),
          )
        ],
      ),
    );
  }
}
