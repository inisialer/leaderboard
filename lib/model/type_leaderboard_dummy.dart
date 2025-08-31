class TypeLeaderboard {
  final String name;

  TypeLeaderboard({
    required this.name,
  });
}

final List<TypeLeaderboard> allTypeLeaderboards = [
  TypeLeaderboard(
    name: "Overall",
  ),
  TypeLeaderboard(
    name: "Kemenangan",
  ),
  TypeLeaderboard(
    name: "Streaks",
  ),
  TypeLeaderboard(
    name: "Jumlah Pertandingan",
  ),
];
