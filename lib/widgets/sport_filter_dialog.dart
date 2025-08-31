import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/bloc/sport/sport_cubit.dart';
import 'package:leaderboard_app/bloc/sport/sport_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/sport_dummy.dart';

class SportFilterDialog extends StatelessWidget {
  const SportFilterDialog({
    super.key,
    required this.cubit,
  });

  final SportCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportCubit, SportState>(builder: (context, state) {
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
              final period = preferredSports[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(period.image),
                title: Text(period.name),
                trailing: Radio<int>(
                  value: index,
                  groupValue: state.selectedIndex,
                  onChanged: (val) {
                    if (val != null) {
                      cubit.selectTempIndex(val);
                    }
                  },
                ),
                onTap: () => cubit.selectTempIndex(index),
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
              final period = allSports[index];
              final globalIndex = preferredSports.length + index;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(period.image),
                title: Text(period.name),
                trailing: Radio<int>(
                  value: globalIndex,
                  groupValue: state.selectedIndex,
                  onChanged: (val) {
                    if (val != null) {
                      cubit.selectTempIndex(val);
                    }
                  },
                ),
                onTap: () => cubit.selectTempIndex(globalIndex),
              );
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedIndex == null
                  ? null
                  : () {
                      cubit.applySport(allCombined);
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
