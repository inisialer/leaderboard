import 'package:flutter/material.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/widgets/main_button.dart';

class CardResultEmpty extends StatelessWidget {
  const CardResultEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/img_bg.png'),
              alignment: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Image.asset(
            'assets/images/img_empty.png',
            scale: 4,
          ),
          Text(
            'Leaderboard belum tersedia',
            style: white16w600,
          ),
          Text(
            'Jadilah yang pertama untuk memulai pertandingan dan raih posisi terbaikmu!',
            style: white14w400,
            textAlign: TextAlign.center,
          ),
          MainButton(
            title: 'Mulai Tanding',
            textStyle: base14w600,
            width: 144,
            backgroundColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
