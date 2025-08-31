import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/category/category_state.dart';
import 'package:leaderboard_app/model/category_dummy.dart';

class CategorySportCubit extends Cubit<CategorySportState> {
  CategorySportCubit() : super(CategorySportState());

  void selectTempIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void applyCategorySport(List<CategorySport> categorySports) {
    if (state.selectedIndex != null) {
      emit(state.copyWith(
          appliedCategorySport: categorySports[state.selectedIndex!]));
    }
  }
}
