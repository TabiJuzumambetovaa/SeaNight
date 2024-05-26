import 'package:flutter/material.dart';
import 'package:flutter_sea_night/utils/app_colors.dart';
import 'package:flutter_sea_night/utils/app_icon.dart';
import 'package:flutter_sea_night/utils/app_pngs.dart';
import 'package:gap/gap.dart';

import '../utils/app_fonts.dart';
import '../utils/game.dart';
import '../widget/game_cell.dart';
import '../widget/header_info_current_balance_close.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Game game = Game();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    game.revealCell(0, 0, context);
  }

  void movePlayerLeft() {
    setState(() {
      game.movePlayerLeft(context);
    });
  }

  void movePlayerRight() {
    setState(() {
      game.movePlayerRight(context);
    });
  }

  void movePlayerUp() {
    setState(() {
      game.movePlayerUp(context);
    });
  }

  void movePlayerDown() {
    setState(() {
      game.movePlayerDown(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double cellWidth = MediaQuery.of(context).size.width / game.columns;
    double cellHeight = MediaQuery.of(context).size.height / game.rows;
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
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: game.columns,
                    ),
                    itemCount: game.rows * game.columns,
                    itemBuilder: (context, index) {
                      int row = index ~/ game.columns;
                      int column = index % game.columns;
                      Cell cell = game.matrix[row][column];

                      return GameCell(
                        cell: cell,
                        row: row,
                        column: column,
                        cellWidth: cellWidth,
                        cellHeight: cellHeight,
                        showPlayer: game.playerRow == row &&
                            game.playerColumn == column,
                      );
                    },
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const AppIcon(AppIcons.left),
                      onPressed: movePlayerLeft,
                    ),
                    IconButton(
                      icon: const AppIcon(AppIcons.up),
                      onPressed: movePlayerUp,
                    ),
                    IconButton(
                      icon: const AppIcon(AppIcons.down),
                      onPressed: movePlayerDown,
                    ),
                    IconButton(
                      icon: const AppIcon(AppIcons.right),
                      onPressed: movePlayerRight,
                    ),
                    
                  ],
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
