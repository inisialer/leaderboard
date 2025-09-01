import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaderboard_app/bloc/filter/filter_cubit.dart';
import 'package:leaderboard_app/bloc/filter/filter_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';

class LeaderboardItemFilterDialog extends StatelessWidget {
  const LeaderboardItemFilterDialog({super.key, required this.cubit});

  final FilterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        // 1. ambil semua types
        final types = state.filteredLeaderboard
            .map((sport) => sport["category"] ?? sport["type"])
            .toSet()
            .toList();

        // 2. buat list global leaderboard items (flat)
        final leaderboardItems = types.expand((type) {
          final sportsByType = state.filteredLeaderboard
              .where((sport) => (sport["category"] ?? sport["type"]) == type)
              .toList();

          return sportsByType.expand((sport) {
            final region = sport["region"];
            return (sport["leaderboard"] as List<dynamic>).map((item) {
              return {
                ...item,
                "region": region,
                "type": type,
              };
            });
          });
        }).toList();

        return ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            // handle drag indicator
            Center(
              child: Container(
                height: 6,
                width: MediaQuery.sizeOf(context).width / 8,
                decoration: BoxDecoration(
                  color: const Color(0xffCACCCF),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // tampil per type
            ...types.map((type) {
              // filter items sesuai type
              final itemsByType = leaderboardItems
                  .where((item) => item['type'] == type)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header type
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(type, style: black14w600),
                  ),

                  // list item per type
                  ...itemsByType.map((item) {
                    final globalIndex = leaderboardItems.indexOf(item);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item["team"] ?? item["player"] ?? ""),
                      subtitle: Text(item['region'] ?? ""),
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: _buildAvatar(
                          type.toLowerCase(),
                          (item["players"] != null)
                              ? (item["players"] as List<dynamic>)
                                  .map((p) => p["image"].toString())
                                  .toList()
                              : [item["image"].toString()],
                        ),
                      ),
                      trailing: Radio<int>(
                        value: globalIndex,
                        groupValue: state.selectedLeaderboardItem,
                        onChanged: (val) {
                          if (val != state.selectedLeaderboardItem) {
                            cubit.updateSelectedLeadeboardItem(val);
                            log(state.selectedLeaderboardItem.toString());
                          }
                        },
                      ),
                      onTap: () {
                        if (globalIndex != state.selectedLeaderboardItem) {
                          cubit.updateSelectedLeadeboardItem(globalIndex);
                        }
                      },
                    );
                  }),
                ],
              );
            }).toList(),

            const SizedBox(height: 16),

            // tombol Terapkan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.selectedLeaderboardItem == null
                    ? null
                    : () {
                        final selectedItem =
                            leaderboardItems[state.selectedLeaderboardItem!];
                        cubit.updateLeadeboardItem(selectedItem["player"]);
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Terapkan", style: white14w400),
              ),
            ),
          ],
        );
      },
    );
  }

  // Avatar builder
  Widget _buildAvatar(String type, List<String> images) {
    if (images.length > 1) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              image: DecorationImage(image: AssetImage(images[0])),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(image: AssetImage(images[1])),
              ),
            ),
          ),
        ],
      );
    } else {
      return CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(images.first),
      );
    }
  }
}
