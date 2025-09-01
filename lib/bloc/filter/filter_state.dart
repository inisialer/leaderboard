class FilterState {
  final String? season;
  final int? selectedSeason;
  final String? sport;
  final int? selectedSport;
  final String? category;
  final int? selectedCategory;
  final String? region;
  final int? selectedRegion;
  final List<Map<String, dynamic>> filteredLeaderboard;

  FilterState({
    this.season,
    this.selectedSeason,
    this.sport,
    this.selectedSport,
    this.category,
    this.selectedCategory,
    this.region,
    this.selectedRegion,
    this.filteredLeaderboard = const [],
  });

  FilterState copyWith({
    String? season,
    int? selectedSeason,
    String? sport,
    int? selectedSport,
    String? category,
    int? selectedCategory,
    String? region,
    int? selectedRegion,
    List<Map<String, dynamic>>? filteredLeaderboard,
  }) {
    return FilterState(
      season: season ?? this.season,
      selectedSeason: selectedSeason ?? this.selectedSeason,
      sport: sport ?? this.sport,
      selectedSport: selectedSport ?? this.selectedSport,
      category: category ?? this.category,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      region: region ?? this.region,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      filteredLeaderboard: filteredLeaderboard ?? this.filteredLeaderboard,
    );
  }
}
