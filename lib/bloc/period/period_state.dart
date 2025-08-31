import 'package:leaderboard_app/model/period_dummy.dart';

class PeriodState {
  final int? selectedIndex;
  final Period? appliedPeriod;

  PeriodState({this.selectedIndex, this.appliedPeriod});

  PeriodState copyWith({int? selectedIndex, Period? appliedPeriod}) {
    return PeriodState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      appliedPeriod: appliedPeriod ?? this.appliedPeriod,
    );
  }
}
