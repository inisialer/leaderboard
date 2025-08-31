import 'package:leaderboard_app/model/category_dummy.dart';

class CategorySportState {
  final int? selectedIndex;
  final CategorySport? appliedCategorySport;

  CategorySportState({
    this.selectedIndex,
    this.appliedCategorySport,
  });

  CategorySportState copyWith({
    int? selectedIndex,
    CategorySport? appliedCategorySport,
  }) {
    return CategorySportState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      appliedCategorySport: appliedCategorySport ?? this.appliedCategorySport,
    );
  }

  factory CategorySportState.initial() {
    return CategorySportState(
      selectedIndex: 2,
      appliedCategorySport: allCategorySports[2],
    );
  }
}
