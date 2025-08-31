import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/bloc/type-leaderboard/type_leaderboard_cubit.dart';
import 'package:leaderboard_app/bloc/type-leaderboard/type_leaderboard_state.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/type_leaderboard_dummy.dart';

class TypeLeaderboardFilterDialog extends StatelessWidget {
  const TypeLeaderboardFilterDialog({
    super.key,
    required this.cubit,
  });

  final TypeLeaderboardCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypeLeaderboardCubit, TypeLeaderboardState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pilih TypeLeaderboard",
                style: black16w600,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          ...allTypeLeaderboards.asMap().entries.map((entry) {
            final index = entry.key;
            final sport = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
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
                            cubit.selectTempIndex(index);
                            cubit.applyTypeLeaderboard(allTypeLeaderboards);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      onTap: () {
                        cubit.selectTempIndex(index);
                        cubit.applyTypeLeaderboard(allTypeLeaderboards);
                        Navigator.pop(context);
                      }),
                  const Divider(
                    height: 0,
                    color: Color(0xffE8E8E8),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(
            height: 40.0,
          ),
        ],
      );
    });
  }
}
