import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/bloc/category/category_cubit.dart';
import 'package:leaderboard_app/bloc/category/category_state.dart';
import 'package:leaderboard_app/bloc/filter/filter_cubit.dart';
import 'package:leaderboard_app/bloc/filter/filter_state.dart';
import 'package:leaderboard_app/bloc/region/region_cubit.dart';
import 'package:leaderboard_app/bloc/region/region_state.dart';
import 'package:leaderboard_app/bloc/sport/sport_cubit.dart';
import 'package:leaderboard_app/bloc/sport/sport_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/global_function.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/ui/home/components/card_podium.dart';
import 'package:leaderboard_app/ui/home/components/card_winner.dart';
import 'package:leaderboard_app/widgets/card_filter.dart';
import 'package:leaderboard_app/widgets/card_result_empty.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        Map<String, dynamic>? sport;
        if (state.filteredLeaderboard.isNotEmpty) {
          sport = state.filteredLeaderboard.first;
        }

        return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.arrow_back_ios),
              title: GestureDetector(
                onTap: () {
                  showPeriodPicker(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Text(
                      state.season ?? "Current Season",
                      style: white16w600,
                    ),
                    SvgPicture.asset('assets/icons/ic_play.svg')
                  ],
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    showPointRulesDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                        color: darkPurpleColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: SvgPicture.asset(
                      'assets/icons/ic_group.svg',
                      width: 20,
                    ),
                  ),
                )
              ],
            ),
            body: sport == null
                ? CardResultEmpty()
                : SlidingUpPanel(
                    minHeight: 210,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img_bg.png'),
                              alignment: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 4,
                              children: [
                                CardDropdown(
                                  title: state.sport ?? 'Mini Soccer',
                                  onTap: () {
                                    showSportPicker(context);
                                  },
                                ),

                                CardDropdown(
                                  title: state.category ?? 'Komunitas',
                                  onTap: () {
                                    showCategorySportPicker(context);
                                  },
                                ),
                                CardDropdown(
                                  title: state.region ?? 'Surabaya',
                                  onTap: () {
                                    showRegionPicker(context);
                                  },
                                ),

                                // BlocBuilder<TypeLeaderboardCubit, TypeLeaderboardState?>(
                                //   builder: (context, region) {
                                //     return CardDropdown(
                                //       title:
                                //           region?.appliedTypeLeaderboard?.name ?? 'Overall',
                                //       onTap: () {
                                //         showTypeLeaderboardPicker(context);
                                //       },
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          BlocBuilder<FilterCubit, FilterState>(
                            builder: (context, filterState) {
                              final selectedCategory =
                                  filterState.category?.toLowerCase() ?? '';
                              final selectedSport =
                                  filterState.sport?.toLowerCase() ?? '';
                              final selectedRegion = filterState.region ?? '';

                              final isMiniSoccer =
                                  selectedSport == 'mini soccer';
                              final isTunggal = selectedCategory == 'tunggal';
                              final isGanda = selectedCategory == 'ganda' ||
                                  selectedCategory == 'double';

                              // Ambil item pertama dari filteredLeaderboard
                              final sportData =
                                  filterState.filteredLeaderboard.isNotEmpty
                                      ? filterState.filteredLeaderboard.first
                                      : null;

                              final firstItem = sportData != null &&
                                      (sportData['leaderboard'] as List)
                                          .isNotEmpty
                                  ? (sportData['leaderboard'] as List).first
                                  : null;

                              // Tentukan subtitle sesuai tipe
                              String subtitle;
                              if (isMiniSoccer) {
                                subtitle = selectedRegion.isNotEmpty
                                    ? selectedRegion
                                    : 'Unknown';
                              } else if (isTunggal) {
                                subtitle = firstItem?['team'] ??
                                    firstItem?['player'] ??
                                    '-';
                              } else if (isGanda) {
                                final players = firstItem?['players'] as List?;
                                subtitle = players != null &&
                                        players.length >= 2
                                    ? '@${players[0]['name']} / @${players[1]['name']}'
                                    : '-';
                              } else {
                                subtitle = '-';
                              }

                              // Tentukan images sesuai tipe
                              List<String> images;
                              if (isMiniSoccer) {
                                images = [
                                  firstItem?['image'] ??
                                      'assets/images/img_avatar1.png'
                                ];
                              } else if (isTunggal) {
                                images = [
                                  firstItem?['image'] ??
                                      'assets/images/img_avatar6.png'
                                ];
                              } else {
                                final players = firstItem?['players'] as List?;
                                images = players != null && players.length >= 2
                                    ? [players[0]['image'], players[1]['image']]
                                    : [
                                        'assets/images/img_avatar6.png',
                                        'assets/images/img_avatar8.png'
                                      ];
                              }

                              return CardWinner(
                                onTapArrow: () =>
                                    showLeaderboardItemPicker(context),
                                title: firstItem?['team'] ??
                                    firstItem?['player'] ??
                                    'Unknown',
                                type: isMiniSoccer
                                    ? WinnerType.soccer
                                    : isTunggal
                                        ? WinnerType.single
                                        : WinnerType.duo,
                                subtitle: subtitle,
                                images: images,
                                points: firstItem?['points'] ?? 0,
                                rank: firstItem?['rank'] ?? 0,
                                onShare: () {
                                  print(
                                      'Share ${isMiniSoccer ? 'komunitas' : 'individual'}!');
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          BlocBuilder<FilterCubit, FilterState>(
                            builder: (context, filterState) {
                              final filteredSports =
                                  filterState.filteredLeaderboard;
                              if (filteredSports.isEmpty)
                                return const SizedBox();

                              final sport = filteredSports.first;
                              final leaderboard =
                                  sport['leaderboard'] as List<dynamic>;

                              WinnerType getWinnerType(
                                  Map<String, dynamic> sport) {
                                final type = (sport['type'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                final category = (sport['category'] ?? '')
                                    .toString()
                                    .toLowerCase();

                                if (type == 'komunitas')
                                  return WinnerType.soccer;
                                if (category == 'tunggal' ||
                                    category == 'single')
                                  return WinnerType.single;
                                return WinnerType.duo;
                              }

                              List<String> getImages(
                                  Map<String, dynamic> item) {
                                if (item.containsKey('players') &&
                                    item['players'] is List) {
                                  return List<String>.from(
                                      (item['players'] as List)
                                          .map((p) => p['image'] as String));
                                }

                                if (item.containsKey('image')) {
                                  return [item['image'] as String];
                                }

                                return ['assets/images/default.png'];
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                spacing: 16,
                                children: [
                                  if (leaderboard.length > 1)
                                    Expanded(
                                      child: CardPodium(
                                        rank: 2,
                                        height: 130,
                                        name: leaderboard[1]['team'] ??
                                            leaderboard[1]['player'] ??
                                            '',
                                        points:
                                            leaderboard[1]['points'].toString(),
                                        type: getWinnerType(sport),
                                        images: getImages(leaderboard[1]),
                                      ),
                                    ),
                                  if (leaderboard.isNotEmpty)
                                    Expanded(
                                      child: CardPodium(
                                        rank: 1,
                                        height: 180,
                                        name: leaderboard[0]['team'] ??
                                            leaderboard[0]['player'] ??
                                            '',
                                        points:
                                            leaderboard[0]['points'].toString(),
                                        type: getWinnerType(sport),
                                        images: getImages(leaderboard[0]),
                                      ),
                                    ),
                                  if (leaderboard.length > 2)
                                    Expanded(
                                      child: CardPodium(
                                        rank: 3,
                                        height: 100,
                                        name: leaderboard[2]['team'] ??
                                            leaderboard[2]['player'] ??
                                            '',
                                        points:
                                            leaderboard[2]['points'].toString(),
                                        type: getWinnerType(sport),
                                        images: getImages(leaderboard[2]),
                                      ),
                                    ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    panel: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          height: 4,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.separated(
                              itemCount:
                                  (sport['leaderboard'] as List).length > 3
                                      ? (sport['leaderboard'] as List)
                                          .sublist(3)
                                          .length
                                      : 0,
                              separatorBuilder: (context, index) => SizedBox(
                                  height: 32,
                                  child: Divider(
                                    color: dividerColor,
                                  )),
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final data =
                                    (sport?['leaderboard'] as List).length > 3
                                        ? (sport?['leaderboard'] as List)
                                            .sublist(3)[index]
                                        : null;

                                if (data == null) return SizedBox.shrink();

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 8,
                                      children: [
                                        Text('${index + 4}'),
                                        Image.asset(
                                          getItemImage(data),
                                          width: 40,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['team'],
                                              style: black14w400,
                                            ),
                                            Text(
                                              sport?['region'],
                                              style: semiBlack12w400,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/ic_changes_up.svg'),
                                        Text(
                                          '${data['points']} Pts',
                                          style: semiBlack12w400,
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
