import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/period/period_cubit.dart';
import 'package:leaderboard_app/bloc/period/period_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/period_dummy.dart';

class PeriodFilterDialog extends StatelessWidget {
  const PeriodFilterDialog({
    super.key,
    required this.cubit,
  });

  final PeriodCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeriodCubit, PeriodState>(builder: (context, state) {
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.selectedIndex == null
                  ? null
                  : () {
                      cubit.applyPeriod(dummyPeriods);
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
