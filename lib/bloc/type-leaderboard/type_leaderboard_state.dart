import 'package:leaderboard_app/model/region_dummy.dart';
import 'package:leaderboard_app/model/type_leaderboard_dummy.dart';

class TypeLeaderboardState {
  final int? selectedIndex;
  final TypeLeaderboard? appliedTypeLeaderboard;

  TypeLeaderboardState({
    this.selectedIndex,
    this.appliedTypeLeaderboard,
  });

  TypeLeaderboardState copyWith({
    int? selectedIndex,
    TypeLeaderboard? appliedTypeLeaderboard,
    String? searchQuery,
  }) {
    return TypeLeaderboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      appliedTypeLeaderboard:
          appliedTypeLeaderboard ?? this.appliedTypeLeaderboard,
    );
  }

  factory TypeLeaderboardState.initial() {
    return TypeLeaderboardState(
      selectedIndex: 0,
      appliedTypeLeaderboard: allTypeLeaderboards[0],
    );
  }
}
