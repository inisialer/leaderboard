class FilterState {
  final String? season;
  final int? selectedSeason;
  final String? sport;
  final int? selectedSport;
  final String? category;
  final int? selectedCategory;
  final String? region;
  final int? selectedRegion;
  final Map<String, dynamic>? leaderboardItem;
  final int? selectedLeaderboardItem;
  final String searchQuery;
  final List<Map<String, dynamic>> filteredLeaderboard;

  FilterState({
    this.season,
    this.searchQuery = '',
    this.selectedSeason,
    this.sport,
    this.selectedSport,
    this.category,
    this.selectedCategory,
    this.region,
    this.selectedRegion,
    this.leaderboardItem,
    this.selectedLeaderboardItem,
    this.filteredLeaderboard = const [],
  });

  FilterState copyWith({
    String? season,
    String? searchQuery,
    int? selectedSeason,
    String? sport,
    int? selectedSport,
    String? category,
    int? selectedCategory,
    String? region,
    int? selectedRegion,
    Map<String, dynamic>? leaderboardItem,
    int? selectedLeaderboardItem,
    List<Map<String, dynamic>>? filteredLeaderboard,
  }) {
    return FilterState(
      season: season ?? this.season,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSeason: selectedSeason ?? this.selectedSeason,
      sport: sport ?? this.sport,
      selectedSport: selectedSport ?? this.selectedSport,
      category: category ?? this.category,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      region: region ?? this.region,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      leaderboardItem: leaderboardItem ?? this.leaderboardItem,
      selectedLeaderboardItem:
          selectedLeaderboardItem ?? this.selectedLeaderboardItem,
      filteredLeaderboard: filteredLeaderboard ?? this.filteredLeaderboard,
    );
  }
}
