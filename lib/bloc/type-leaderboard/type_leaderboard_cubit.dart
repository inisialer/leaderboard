import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/type-leaderboard/type_leaderboard_state.dart';
import 'package:leaderboard_app/model/type_leaderboard_dummy.dart';

class TypeLeaderboardCubit extends Cubit<TypeLeaderboardState> {
  TypeLeaderboardCubit() : super(TypeLeaderboardState.initial());

  void selectTempIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void applyTypeLeaderboard(List<TypeLeaderboard> allTypeLeaderboards) {
    if (state.selectedIndex != null) {
      emit(state.copyWith(
          appliedTypeLeaderboard: allTypeLeaderboards[state.selectedIndex!]));
    }
  }
}
