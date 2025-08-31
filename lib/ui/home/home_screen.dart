import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaderboard_app/bloc/category/category_cubit.dart';
import 'package:leaderboard_app/bloc/category/category_state.dart';
import 'package:leaderboard_app/bloc/region/region_cubit.dart';
import 'package:leaderboard_app/bloc/region/region_state.dart';
import 'package:leaderboard_app/bloc/period/period_cubit.dart';
import 'package:leaderboard_app/bloc/period/period_state.dart';
import 'package:leaderboard_app/bloc/sport/sport_cubit.dart';
import 'package:leaderboard_app/bloc/sport/sport_state.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/global_function.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/ui/home/components/card_podium.dart';
import 'package:leaderboard_app/ui/home/components/card_winner.dart';
import 'package:leaderboard_app/widgets/card_filter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          title: InkWell(
            onTap: () {
              showPeriodPicker(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                BlocBuilder<PeriodCubit, PeriodState?>(
                  builder: (context, period) {
                    return Text(
                      period?.appliedPeriod?.name ?? "Current Season",
                      style: white16w600,
                    );
                  },
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
        body: SlidingUpPanel(
          minHeight: 210,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/img_bg.png'),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    BlocBuilder<SportCubit, SportState?>(
                      builder: (context, sport) {
                        return CardDropdown(
                          title: sport?.appliedSport?.name ?? 'Mini Soccer',
                          onTap: () {
                            showSportPicker(context);
                          },
                        );
                      },
                    ),
                    BlocBuilder<SportCubit, SportState?>(
                      builder: (context, sport) {
                        final isMiniSoccer =
                            sport?.appliedSport?.name == 'Mini Soccer' ||
                                sport?.appliedSport?.name == null;
                        if (isMiniSoccer) return const SizedBox.shrink();
                        return BlocBuilder<CategorySportCubit,
                            CategorySportState?>(
                          builder: (context, categoryState) {
                            return CardDropdown(
                              title:
                                  categoryState?.appliedCategorySport?.name ??
                                      'Komunitas',
                              onTap: () {
                                showCategorySportPicker(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                    BlocBuilder<RegionCubit, RegionState?>(
                      builder: (context, region) {
                        return CardDropdown(
                          title: region?.appliedRegion?.name ?? 'Surabaya',
                          onTap: () {
                            showRegionPicker(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
                BlocBuilder<SportCubit, SportState?>(
                  builder: (context, sport) {
                    final isMiniSoccer =
                        sport?.appliedSport?.name == 'Mini Soccer' ||
                            sport?.appliedSport?.name == null;
                    return BlocBuilder<CategorySportCubit, CategorySportState?>(
                      builder: (context, categoryState) {
                        return !categoryState!
                                        .appliedCategorySport!.isIndividu &&
                                    !categoryState
                                        .appliedCategorySport!.isTunggal ||
                                isMiniSoccer
                            ? CardWinner(
                                type: WinnerType.soccer,
                                title: 'Far East United',
                                subtitle: 'Surabaya',
                                images: ['assets/images/img_avatar1.png'],
                                points: 50,
                                rank: 456,
                                onShare: () {
                                  print('Share komunitas!');
                                },
                              )
                            : categoryState.appliedCategorySport!.isIndividu &&
                                    categoryState
                                        .appliedCategorySport!.isTunggal
                                ? CardWinner(
                                    type: WinnerType.single,
                                    title: 'Budiman / Ravi',
                                    subtitle: '@budimantanu / @raviahmad',
                                    images: [
                                      'assets/images/img_avatar6.png',
                                    ],
                                    points: 50,
                                    rank: 456,
                                    onShare: () {},
                                  )
                                : CardWinner(
                                    type: WinnerType.duo,
                                    title: 'Budiman / Ravi',
                                    subtitle: '@budimantanu / @raviahmad',
                                    images: [
                                      'assets/images/img_avatar6.png',
                                      'assets/images/img_avatar8.png',
                                    ],
                                    points: 50,
                                    rank: 456,
                                    onShare: () {},
                                  );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 16,
                  children: [
                    CardPodium(
                        rank: 2,
                        height: 130,
                        name: 'Reza',
                        imageUrl: 'assets/images/img_avatar5.png',
                        points: '234'),
                    CardPodium(
                        rank: 1,
                        height: 180,
                        name: 'Reza2',
                        imageUrl: 'assets/images/img_avatar6.png',
                        points: '245'),
                    CardPodium(
                        rank: 3,
                        height: 84,
                        name: 'Reza2',
                        imageUrl: 'assets/images/img_avatar7.png',
                        points: '230'),
                  ],
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) => SizedBox(
                      height: 32,
                      child: Divider(
                        color: dividerColor,
                      )),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Text('${index + 4}'),
                            Image.asset(
                              'assets/images/img_avatar1.png',
                              scale: 3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Blue House',
                                  style: black14w400,
                                ),
                                Text(
                                  'Surabaya',
                                  style: semiBlack12w400,
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset('assets/icons/ic_changes_up.svg'),
                            Text(
                              '105 Pts',
                              style: semiBlack12w400,
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
