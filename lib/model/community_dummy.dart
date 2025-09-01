class LeaderboardItem {
  final String team;
  final int points;
  final String region;
  final String type;
  final List<String> image;

  LeaderboardItem({
    required this.team,
    required this.points,
    required this.region,
    required this.type,
    required this.image,
  });
}

final List<LeaderboardItem> allLeaderboardItem = [
  LeaderboardItem(
    team: "Far East United",
    points: 50,
    region: "Surabaya",
    type: "Komunitas",
    image: ['assets/images/img_avatar3.png'],
  ),
  LeaderboardItem(
    team: "Le Tropico Sports Club",
    points: 25,
    region: "Bandung",
    type: "Tunggal",
    image: ['assets/images/img_avatar8.png'],
  ),
  LeaderboardItem(
    team: "Le Tropico Sports Club",
    points: 25,
    region: "Bandung",
    type: "Ganda",
    image: ['assets/images/img_avatar8.png', 'assets/images/img_avatar6.png'],
  ),
];
