import 'package:flutter/material.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

enum WinnerType { single, duo, soccer }

class CardPodium extends StatelessWidget {
  const CardPodium({
    super.key,
    required this.rank,
    required this.height,
    required this.name,
    required this.points,
    required this.type,
    required this.images,
  });

  final int rank;
  final double height;
  final String name;
  final String points;
  final WinnerType type;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 60,
          child: Stack(
            children: [
              Positioned.fill(
                  left: type == WinnerType.duo ? 20 : 0, child: _buildAvatar()),
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
                ),
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

  Widget _buildAvatar() {
    Widget buildCircle(String image, {double left = 0}) {
      return Positioned(
        left: left,
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
              image: AssetImage(image),
            ),
          ),
        ),
      );
    }

    switch (type) {
      case WinnerType.duo:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            buildCircle(images[0]),
            if (images.length > 1) buildCircle(images[1], left: 20),
          ],
        );
      case WinnerType.single:
      case WinnerType.soccer:
      default:
        return CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(images.first),
        );
    }
  }
}
