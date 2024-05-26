import 'package:flutter/material.dart';

import '../utils/game.dart';
import '../utils/app_colors.dart';
import '../utils/game_function.dart';


class GameCell extends StatelessWidget {
  const GameCell({
    super.key,
    required this.cell,
    required this.row,
    required this.column,
    required this.cellWidth,
    required this.cellHeight,
    required this.showPlayer,
  });

  final Cell cell;
  final int row;
  final int column;
  final double cellWidth;
  final double cellHeight;
  final bool showPlayer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: cellWidth,
          height: cellHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.veryLightLagoon,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: cell.isRevealed
                ? GameFunction.getCellColor(cell.type)
                : GameFunction.buildFindIcon(cell.isRevealed),
          ),
        ),
        if (showPlayer)
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'assets/png/defaultCharacter.png',
              width: cellWidth,
              height: cellHeight,
            ),
          ),
      ],
    );
  }
}
