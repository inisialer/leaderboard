import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/bloc/filter/filter_cubit.dart';
import 'package:leaderboard_app/bloc/filter/filter_state.dart';
import 'package:leaderboard_app/bloc/region/region_cubit.dart';
import 'package:leaderboard_app/bloc/region/region_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/region_dummy.dart';
import 'package:leaderboard_app/model/sport_dummy.dart';
import 'package:leaderboard_app/widgets/main_textfield.dart';

class RegionFilterDialog extends StatelessWidget {
  const RegionFilterDialog({
    super.key,
    required this.cubit,
  });

  final FilterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
      final filteredRegions = allRegions
          .where((region) => region.name
              .toLowerCase()
              .contains(state.searchQuery.toLowerCase()))
          .toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pilih Region",
                style: black16w600,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          MainTextFormField(
            hintText: 'Cari nama kota',
            onChanged: (value) => cubit.setSearchQuery(value),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/icons/ic_search.svg',
                width: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
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
          state.searchQuery.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: filteredRegions.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    color: Color(0xffE8E8E8),
                  ),
                  itemBuilder: (context, index) {
                    final region = filteredRegions[index];
                    final isSelected = state.region == region.name;

                    return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        title: Text(
                          region.name,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xff7A5AF8)
                                : const Color(0xff52575C),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          final selected = filteredRegions[index];
                          log(selected.name); // ✅ sesuai search
                          cubit.updateSelectedRegion(
                              allRegions.indexOf(selected));
                          cubit.updateRegion(selected.name);
                          Navigator.pop(context);
                        });
                  },
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(allRegions.length, (index) {
                    final region = allRegions[index];
                    final isSelected = state.region == region.name;

                    return GestureDetector(
                      onTap: () {
                        final selected = allRegions[index];
                        log(selected
                            .name); // ✅ Sekarang bakal log sesuai yg diklik
                        cubit.updateSelectedRegion(index);
                        cubit.updateRegion(selected.name);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffF5E6E9)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xffF5E6E9)
                                : const Color(0xffE8E8E8),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          region.name,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xff7A5AF8)
                                : const Color(0xff52575C),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      );
    });
  }
}
