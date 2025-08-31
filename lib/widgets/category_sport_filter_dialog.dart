import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/bloc/category/category_cubit.dart';
import 'package:leaderboard_app/bloc/category/category_state.dart';
import 'package:leaderboard_app/bloc/sport/sport_cubit.dart';
import 'package:leaderboard_app/bloc/sport/sport_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/category_dummy.dart';
import 'package:leaderboard_app/model/sport_dummy.dart';

class CategorySportFilterDialog extends StatelessWidget {
  const CategorySportFilterDialog({
    super.key,
    required this.cubit,
  });

  final CategorySportCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorySportCubit, CategorySportState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kategori",
                  style: black16w600,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const DottedLine(
              dashLength: 4,
              dashGapLength: 4,
              lineThickness: 1,
              dashColor: Color(0xffE8E8E8),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "Individu",
              style: black14w600,
            ),
            const SizedBox(height: 16),
            const Divider(
              height: 1,
              color: Color(0xffE8E8E8),
            ),
            ...allCategorySports
                .asMap()
                .entries
                .where((entry) => entry.value.isIndividu)
                .map((entry) {
              final index = entry.key;
              final sport = entry.value;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        sport.name,
                        style: GoogleFonts.rubik(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
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
                    ),
                    const Divider(
                      height: 0,
                      color: Color(0xffE8E8E8),
                    ),
                  ],
                ),
              );
            }),
            ...allCategorySports
                .asMap()
                .entries
                .where((entry) => !entry.value.isIndividu)
                .map((entry) {
              final index = entry.key;
              final sport = entry.value;
              return ListTile(
                contentPadding: EdgeInsets.only(right: 24),
                title: Text(
                  sport.name,
                  style: GoogleFonts.rubik(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
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
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.selectedIndex == null
                    ? null
                    : () {
                        cubit.applyCategorySport(allCategorySports);
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
    });
  }
}
