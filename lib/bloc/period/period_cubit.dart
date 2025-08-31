import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/period/period_state.dart';
import 'package:leaderboard_app/model/period_dummy.dart';

class PeriodCubit extends Cubit<PeriodState> {
  PeriodCubit() : super(PeriodState());

  void selectTempIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void applyPeriod(List<Period> periods) {
    if (state.selectedIndex != null) {
      emit(state.copyWith(appliedPeriod: periods[state.selectedIndex!]));
    }
  }
}
