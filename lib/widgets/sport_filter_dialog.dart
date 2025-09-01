import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/bloc/filter/filter_cubit.dart';
import 'package:leaderboard_app/bloc/filter/filter_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/sport_dummy.dart';

class SportFilterDialog extends StatelessWidget {
  const SportFilterDialog({
    super.key,
    required this.cubit,
  });

  final FilterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
      final allCombined = [...preferredSports, ...allSports];

      return Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cabang Olahraga",
                style: black16w600,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xffF1F1F1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "Preferensi Olahragamu",
              style: black14w600,
            ),
          ),
          ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: dividerColor,
            ),
            itemCount: preferredSports.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final sport = preferredSports[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(sport.image),
                title: Text(sport.name),
                trailing: Radio<int>(
                  value: index,
                  groupValue: state.selectedSport,
                  onChanged: (val) {
                    if (val != null) {
                      cubit.updateSelectedSport(val);
                    }
                  },
                ),
                onTap: () => cubit.updateSelectedSport(index),
              );
            },
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xffF1F1F1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "Semua Olahraga",
              style: black14w600,
            ),
          ),
          ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: dividerColor,
            ),
            itemCount: allSports.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final sport = allSports[index];
              final globalIndex = preferredSports.length + index;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(sport.image),
                title: Text(sport.name),
                trailing: Radio<int>(
                  value: globalIndex,
                  groupValue: state.selectedSport,
                  onChanged: (val) {
                    if (val != null) {
                      cubit.updateSelectedSport(val);
                    }
                  },
                ),
                onTap: () => cubit.updateSelectedSport(globalIndex),
              );
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedSport == null
                  ? null
                  : () {
                      cubit.updateSport(
                          allCombined[state.selectedSport ?? 0].name);
                      Navigator.pop(context);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Terapkan",
                style: white14w400,
              ),
            ),
          ),
        ],
      );
    });
  }
}
