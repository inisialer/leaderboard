class Sport {
  final String name;
  final bool allowSingle;
  final bool allowTeam;

  Sport({
    required this.name,
    this.allowSingle = true,
    this.allowTeam = true,
  });
}

class LeaderboardEntry {
  final String playerName;
  final int rank;
  final int points;
  final String season;
  final Sport sport;
  final String groupType;
  final String location;

  LeaderboardEntry({
    required this.playerName,
    required this.rank,
    required this.points,
    required this.season,
    required this.sport,
    required this.groupType,
    required this.location,
  });
}

final sports = [
  Sport(name: "Badminton", allowSingle: true, allowTeam: true),
  Sport(name: "Tenis Meja", allowSingle: true, allowTeam: true),
  Sport(name: "Tenis", allowSingle: true, allowTeam: true),
  Sport(name: "Padel", allowSingle: false, allowTeam: true),
  Sport(name: "Squash", allowSingle: true, allowTeam: false),
  Sport(name: "Mini Soccer", allowSingle: false, allowTeam: true),
  Sport(name: "Pickleball", allowSingle: true, allowTeam: true),
];

List<LeaderboardEntry> dummyLeaderboard = [
  LeaderboardEntry(
    playerName: "Andi",
    rank: 1,
    points: 1500,
    season: "Summer",
    sport: sports[0],
    groupType: "Tunggal",
    location: "Jakarta",
  ),
  LeaderboardEntry(
    playerName: "Budi & Candra",
    rank: 2,
    points: 1420,
    season: "Summer",
    sport: sports[0],
    groupType: "Beregu",
    location: "Bandung",
  ),
  LeaderboardEntry(
    playerName: "Tim Bandung Legends",
    rank: 1,
    points: 1600,
    season: "Summer",
    sport: sports[5],
    groupType: "Beregu",
    location: "Bandung",
  ),
  LeaderboardEntry(
    playerName: "Maya",
    rank: 3,
    points: 1100,
    season: "Winter",
    sport: sports[6],
    groupType: "Tunggal",
    location: "Medan",
  ),
  LeaderboardEntry(
    playerName: "Tim Jakarta Padel",
    rank: 1,
    points: 1700,
    season: "Summer",
    sport: sports[3],
    groupType: "Beregu",
    location: "Jakarta",
  ),
  LeaderboardEntry(
    playerName: "Rio",
    rank: 2,
    points: 1350,
    season: "Winter",
    sport: sports[4],
    groupType: "Tunggal",
    location: "Bali",
  ),
];
