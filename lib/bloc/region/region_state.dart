import 'package:leaderboard_app/model/region_dummy.dart';

class RegionState {
  final int? selectedIndex;
  final Region? appliedRegion;
  final String searchQuery;

  RegionState({
    this.selectedIndex,
    this.appliedRegion,
    this.searchQuery = '',
  });

  RegionState copyWith({
    int? selectedIndex,
    Region? appliedRegion,
    String? searchQuery,
  }) {
    return RegionState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      appliedRegion: appliedRegion ?? this.appliedRegion,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
