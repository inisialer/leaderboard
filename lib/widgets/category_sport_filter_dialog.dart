import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/bloc/filter/filter_cubit.dart';
import 'package:leaderboard_app/bloc/filter/filter_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/category_dummy.dart';

class CategorySportFilterDialog extends StatelessWidget {
  const CategorySportFilterDialog({
    super.key,
    required this.cubit,
  });

  final FilterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
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
                      contentPadding: EdgeInsets.only(left: 16),
                      title: Text(
                        sport.name,
                        style: GoogleFonts.rubik(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      trailing: Radio<int>(
                        value: index,
                        groupValue: state.selectedCategory,
                        onChanged: (val) {
                          if (val != null) {
                            cubit.updateSelectedCategory(val);
                          }
                        },
                      ),
                      onTap: () => cubit.updateSelectedCategory(index),
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
                contentPadding: EdgeInsets.only(right: 8),
                title: Text(
                  sport.name,
                  style: GoogleFonts.rubik(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                trailing: Radio<int>(
                  value: index,
                  groupValue: state.selectedCategory,
                  onChanged: (val) {
                    if (val != null) {
                      cubit.updateSelectedCategory(val);
                    }
                  },
                ),
                onTap: () => cubit.updateSelectedCategory(index),
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.selectedCategory == null
                    ? null
                    : () {
                        cubit.updateCategory(
                            allCategorySports[state.selectedCategory ?? 0]
                                .name);
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
