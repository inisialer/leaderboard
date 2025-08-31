import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/bloc/period/period_cubit.dart';
import 'package:leaderboard_app/bloc/period/period_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/period_dummy.dart';
import 'package:leaderboard_app/widgets/point_rule_tile.dart';

void showPointRulesDialog(BuildContext context) {
  customBottomSheet(
    context,
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cara Mendapatkan Point",
              style: black16w600,
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        Text(
          "Kamu harus menyelesaikan pertandingan untuk dapat mendapatkan point.",
          style: semiBlack14w400,
        ),
        Text(
          "Hasil Pertandingan",
          style: black14w600,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: dividerColor),
          ),
          child: Column(
            children: [
              PointRuleTile(
                title: "Menang",
                pointText: "+100 Pts",
                pointColor: Colors.green,
              ),
              DottedLine(
                dashColor: dividerColor,
              ),
              PointRuleTile(
                title: "Draw",
                pointText: "+50 Pts",
                pointColor: Colors.blue,
              ),
              DottedLine(
                dashColor: dividerColor,
              ),
              PointRuleTile(
                title: "Kalah",
                pointText: "-50 Pts",
                pointColor: Colors.red,
              ),
            ],
          ),
        ),
        Text(
          "Bonus Point",
          style: black14w600,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bonus Kemenangan",
                    style: black14w400,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "n x 5 Pts",
                      style:
                          GoogleFonts.rubik(color: Colors.green, fontSize: 10),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Point (n) didapatkan berdasarkan selisih peringkat "
                "dengan lawan di leaderboard. Nilai point maksimum yang "
                "dapat ditambahkan adalah 20 Pts",
                style: semiBlack12w400,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showPeriodPicker(BuildContext context) {
  final cubit = context.read<PeriodCubit>();

  customBottomSheet(context,
      BlocBuilder<PeriodCubit, PeriodState>(builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
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
                  groupValue: state.selectedIndex ?? 2,
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
              onPressed: () {
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
      ),
    );
  }));
}

void customBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(padding: const EdgeInsets.all(16), child: child);
      });
}
