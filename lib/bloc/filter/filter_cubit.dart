import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/model/list_leaderboard_dummy.dart';

import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit()
      : super(FilterState(
          season: "Current Season",
          sport: "Mini Soccer",
        )) {
    _applyFilter();
  }
  void updateSeason(String? season) {
    emit(state.copyWith(season: season));
    _applyFilter();
  }

  void updateSelectedSeason(int? selectedSeason) {
    emit(state.copyWith(selectedSeason: selectedSeason));
  }

  void updateSport(String? sport) {
    emit(state.copyWith(sport: sport));
    _applyFilter();
  }

  void updateSelectedSport(int? selectedSport) {
    emit(state.copyWith(selectedSport: selectedSport));
  }

  void updateCategory(String? category) {
    emit(state.copyWith(category: category));
    _applyFilter();
  }

  void updateSelectedCategory(int? selectedCategory) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }

  void updateRegion(String? region) {
    emit(state.copyWith(region: region));
    _applyFilter();
  }

  void updateSelectedRegion(int? selectedRegion) {
    emit(state.copyWith(selectedRegion: selectedRegion));
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void updateLeadeboardItem(Map<String, dynamic>? item) {
    emit(state.copyWith(leaderboardItem: item));
  }

  void updateSelectedLeadeboardItem(int? selectedLeaderboardItem) {
    emit(state.copyWith(selectedLeaderboardItem: selectedLeaderboardItem));
  }

  void _applyFilter() {
    final season = state.season ?? "Current Season"; // default
    final seasonData = dummyLeaderboard.firstWhere(
      (e) => e["season"] == season,
      orElse: () => {},
    );

    if (seasonData.isEmpty) {
      emit(state.copyWith(filteredLeaderboard: []));
      return;
    }

    List<Map<String, dynamic>> sports =
        List<Map<String, dynamic>>.from(seasonData["sports"]);

    sports = sports
        .where((s) => s["name"] == (state.sport ?? 'Mini Soccer'))
        .toList();

    if (state.category != null) {
      sports = sports
          .where((s) =>
              (s["category"]?.toLowerCase() ?? "") ==
              state.category!.toLowerCase())
          .toList();
    }

    if (state.region != null) {
      sports = sports
          .where((s) =>
              s["region"].toString().toLowerCase() ==
              state.region?.toLowerCase())
          .toList();
    }

    emit(state.copyWith(filteredLeaderboard: sports));
  }
}
