import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/filter/filter_cubit.dart';
import 'package:leaderboard_app/bloc/filter/filter_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/period_dummy.dart';

class PeriodFilterDialog extends StatelessWidget {
  const PeriodFilterDialog({
    super.key,
    required this.cubit,
  });

  final FilterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Periode",
                style: black16w600,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: dividerColor,
            ),
            itemCount: dummyPeriods.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final period = dummyPeriods[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(period.range),
                subtitle: period.isCurrent
                    ? const Text(
                        "Current Season",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                trailing: Radio<int>(
                  value: index,
                  groupValue: state.selectedSeason,
                  onChanged: (val) {
                    if (val != null) {
                      cubit.updateSelectedSeason(val);
                    }
                  },
                ),
              );
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedSeason == null
                  ? null
                  : () {
                      cubit.updateSeason(
                          dummyPeriods[state.selectedSeason ?? 0].name);
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
