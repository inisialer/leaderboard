import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/sport/sport_state.dart';
import 'package:leaderboard_app/model/sport_dummy.dart';

class SportCubit extends Cubit<SportState> {
  SportCubit() : super(SportState());

  void selectTempIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void applySport(List<Sport> sports) {
    if (state.selectedIndex != null) {
      emit(state.copyWith(appliedSport: sports[state.selectedIndex!]));
    }
  }
}
