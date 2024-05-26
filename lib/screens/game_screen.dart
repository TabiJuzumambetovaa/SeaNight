// screens/game_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_sea_night/utils/app_colors.dart';
import 'package:flutter_sea_night/utils/app_pngs.dart';
import 'package:gap/gap.dart';

import '../utils/app_fonts.dart';
import '../utils/game_function.dart';
import '../widget/game_cell.dart';
import '../widget/header_info_current_balance_close.dart';
import '../utils/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.lagoon, AppColors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                HeaderInfoCurrentBalanceClose(game: game),
                const Gap(20),
                Expanded(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      GameFunction.handlePanUpdate(context, details);
                    },
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: game.columns,
                      ),
                      itemCount: game.rows * game.columns,
                      itemBuilder: (context, index) {
                        int row = index ~/ game.columns;
                        int column = index % game.columns;
                        Cell cell = game.matrix[row][column];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              game.movePlayer(row, column, context);
                            });
                          },
                          child: GameCell(cell: cell),
                        );
                      },
                    ),
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      game.totalBalance.toString(),
                      style: AppFonts.s24w600.copyWith(color: AppColors.white),
                    ),
                    Image.asset(
                      AppPngs.stackOfCoins,
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
                Text(
                  'Total Balance',
                  style: AppFonts.s14w600
                      .copyWith(color: AppColors.veryLightLagoon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

