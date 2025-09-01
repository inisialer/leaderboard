import 'package:flutter/material.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class CardPodium extends StatelessWidget {
  const CardPodium({
    super.key,
    required this.rank,
    required this.height,
    required this.name,
    required this.imageUrl,
    required this.points,
  });
  final int rank;
  final double height;
  final String name;
  final String imageUrl;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 60,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(imageUrl),
              ),
              if (rank == 1)
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: -45,
                  top: 0,
                  child: Image.asset(
                    'assets/images/img_crown.png',
                    scale: 4,
                  ),
                )
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: white16w600,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(points, style: red9w600),
        ),
        Container(
          height: height,
          width: 96,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade600,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.topCenter,
          child: Text("$rank", style: white72w800),
        ),
      ],
    );
  }
}
