import 'package:leaderboard_app/model/sport_dummy.dart';

class SportState {
  final int? selectedIndex;
  final Sport? appliedSport;

  SportState({this.selectedIndex, this.appliedSport});

  SportState copyWith({int? selectedIndex, Sport? appliedSport}) {
    return SportState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      appliedSport: appliedSport ?? this.appliedSport,
    );
  }
}
