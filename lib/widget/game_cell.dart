import 'package:flutter/material.dart';

import '../utils/game.dart';
import '../utils/app_colors.dart';
import '../utils/game_function.dart';

class GameCell extends StatelessWidget {
  const GameCell({
    super.key,
    required this.cell,
  });

  final Cell cell;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.veryLightLagoon,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: cell.isRevealed
            ? GameFunction.getCellColor(cell.type)
            : GameFunction.buildFindIcon(cell.isRevealed),
      ),
    );
  }
}
