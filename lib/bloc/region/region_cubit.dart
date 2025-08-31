import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/region/region_state.dart';
import 'package:leaderboard_app/model/region_dummy.dart';

class RegionCubit extends Cubit<RegionState> {
  RegionCubit() : super(RegionState());

  void selectTempIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void applyRegion(List<Region> region) {
    if (state.selectedIndex != null) {
      emit(state.copyWith(appliedRegion: region[state.selectedIndex!]));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
