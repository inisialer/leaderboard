import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

enum WinnerType { soccer, duo, single }

class CardWinner extends StatelessWidget {
  final WinnerType type;
  final String title;
  final String subtitle;
  final List<String> images;
  final int points;
  final int rank;
  final VoidCallback? onShare;

  const CardWinner({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.images,
    required this.points,
    required this.rank,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkPurpleColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: _buildAvatar(),
              title: Text(title, style: black14w400),
              subtitle: Text(subtitle, style: semiBlack12w400),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$points Pts',
                  style: white9w800,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: 'Komunitasmu peringkat ', style: white12w400),
                    TextSpan(text: '#$rank, ', style: white12w800),
                    TextSpan(text: 'bagikan yuk!', style: white12w400),
                  ]),
                ),
                InkWell(
                  onTap: onShare,
                  child: SvgPicture.asset('assets/icons/ic_share.svg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    switch (type) {
      case WinnerType.duo:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                image: DecorationImage(
                  image: AssetImage(images[0]),
                ),
              ),
            ),
            Positioned(
              left: 20,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: AssetImage(images[1]),
                  ),
                ),
              ),
            ),
          ],
        );

      case WinnerType.single:
      case WinnerType.soccer:
      default:
        return CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(images.first),
        );
    }
  }
}
