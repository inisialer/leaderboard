import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard_app/bloc/category/category_cubit.dart';
import 'package:leaderboard_app/bloc/region/region_cubit.dart';
import 'package:leaderboard_app/bloc/period/period_cubit.dart';
import 'package:leaderboard_app/bloc/sport/sport_cubit.dart';
import 'package:leaderboard_app/bloc/type-leaderboard/type_leaderboard_cubit.dart';
import 'package:leaderboard_app/helper/color_helper.dart';
import 'package:leaderboard_app/helper/text_helper.dart';
import 'package:leaderboard_app/model/category_dummy.dart';
import 'package:leaderboard_app/ui/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeriodCubit>(
          create: (BuildContext context) => PeriodCubit(),
        ),
        BlocProvider<SportCubit>(
          create: (BuildContext context) => SportCubit(),
        ),
        BlocProvider<RegionCubit>(
          create: (BuildContext context) => RegionCubit(),
        ),
        BlocProvider<CategorySportCubit>(
          create: (BuildContext context) => CategorySportCubit(),
        ),
        BlocProvider<TypeLeaderboardCubit>(
          create: (BuildContext context) => TypeLeaderboardCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Leaderboard',
        theme: ThemeData(
            fontFamily: GoogleFonts.rubik().fontFamily,
            scaffoldBackgroundColor: baseColor,
            appBarTheme: AppBarTheme(
                backgroundColor: baseColor,
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: white16w600)),
        home: const HomeScreen(),
      ),
    );
  }
}
