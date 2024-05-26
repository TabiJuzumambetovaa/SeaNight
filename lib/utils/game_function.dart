// utils/game_function.dart

import 'package:flutter/material.dart';
import 'game.dart';
import 'app_pngs.dart';

class GameFunction {
  static Widget buildFindIcon(bool found) {
    return Image.asset(
      found ? AppPngs.send : AppPngs.seabed,
      width: 56,
      height: 56,
    );
  }

  
  static Widget? getCellColor(CellType type) {
    switch (type) {
      case CellType.special:
        return Image.asset(
          AppPngs.exit,
          width: 56,
        );
      case CellType.gold:
        return Image.asset(
          AppPngs.oneCoins,
          width: 56,
        );
      case CellType.emerald:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
      case CellType.diamond:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
      case CellType.luckyCoin:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
      case CellType.unluckyCoin:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
      case CellType.worm:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
      case CellType.shark:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
      case CellType.empty:
      default:
        return Image.asset(
          AppPngs.send,
          width: 56,
        );
    }
  }

  static void handlePanUpdate(
      BuildContext context, DragUpdateDetails details) {
    Game game = Game();

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.globalToLocal(details.globalPosition);

    int row = (localPosition.dy ~/ (renderBox.size.height / game.rows));
    int column = (localPosition.dx ~/ (renderBox.size.width / game.columns));

    if (row >= 0 &&
        row < game.rows &&
        column >= 0 &&
        column < game.columns) {
      game.movePlayer(row, column, context);
    }
  }
}
