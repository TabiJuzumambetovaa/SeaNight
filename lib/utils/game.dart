import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sea_night/utils/app_colors.dart';
import 'package:gap/gap.dart';

enum CellType {
  empty,
  gold,
  emerald,
  diamond,
  luckyCoin,
  unluckyCoin,
  worm,
  shark,
  special
}

class Cell {
  final CellType type;
  bool isRevealed;

  Cell(this.type) : isRevealed = false;
}

class Game {
  final int rows = 10;
  final int columns = 6;
  final List<List<Cell>> matrix;
  int currentBalance = 0;
  int totalBalance = 100;
  int playerRow = 0;
  int playerColumn = 0;
  bool jackpotResult = false;
  bool antiJackpotResult = false;

  Game()
      : matrix = List.generate(
            10, (_) => List.generate(6, (_) => Cell(CellType.empty))) {
    _initializeMatrix();
  }

  void _initializeMatrix() {
    Random random = Random();

    List<CellType> cells = [];
    cells.addAll(List.filled(26, CellType.empty));
    cells.addAll(List.filled(12, CellType.gold));
    cells.addAll(List.filled(6, CellType.emerald));
    cells.addAll(List.filled(3, CellType.diamond));
    cells.addAll(List.filled(3, CellType.luckyCoin));
    cells.addAll(List.filled(3, CellType.unluckyCoin));
    cells.addAll(List.filled(3, CellType.worm));
    cells.addAll(List.filled(4, CellType.shark));

    cells.shuffle(random);

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        if (i == 0 && j == 0) {
          matrix[i][j] = Cell(CellType.special);
        } else {
          matrix[i][j] = Cell(cells.removeLast());
        }
      }
    }
  }

  void revealCell(int row, int column, BuildContext context) {
    if (row < 0 || row >= rows || column < 0 || column >= columns) return;
    var cell = matrix[row][column];
    if (cell.isRevealed) return;

    cell.isRevealed = true;
    switch (cell.type) {
      case CellType.gold:
        _findGold(context);
        break;
      case CellType.emerald:
        _findEmerald(context);
        break;
      case CellType.diamond:
        _findDiamond(context);
        break;
      case CellType.shark:
        _findShark(context);
        break;
      case CellType.worm:
        _findWorm(context);
        break;
      case CellType.luckyCoin:
        _playJackpot(context);
        break;
      case CellType.unluckyCoin:
        _playAntiJackpot(context);
        break;
      case CellType.special:
        break;
      case CellType.empty:
        break;
    }
  }

  void movePlayer(int newRow, int newColumn, BuildContext context) {
    if (newRow < 0 || newRow >= rows || newColumn < 0 || newColumn >= columns) {
      return;
    }
    playerRow = newRow;
    playerColumn = newColumn;
    revealCell(newRow, newColumn, context);
  }

  bool isGameOver() {
    return playerRow == 0 && playerColumn == 0;
  }

  void _findGold(BuildContext context) {
    currentBalance += 10;
    _showFindResult(
        context, 'assets/png/gold.png', 'Gold', '+10', AppColors.gold);
  }

  void _findEmerald(BuildContext context) {
    currentBalance += 15;
    _showFindResult(
        context, 'assets/png/emerald.png', 'Emerald', '+15', AppColors.green);
  }

  void _findDiamond(BuildContext context) {
    currentBalance += 25;
    _showFindResult(context, 'assets/png/diamond.png', 'Diamond', '+25',
        AppColors.diamondBlue);
  }

  void _findShark(BuildContext context) {
    currentBalance -= 20;
    totalBalance -= (totalBalance * 0.05).toInt();
    _showFindResult(
        context, 'assets/png/shark.png', 'Shark', '', AppColors.red);
  }

  void _findWorm(BuildContext context) {
    _showFindResult(context, 'assets/png/worm.png', 'Worm', 'Device is broken',
        AppColors.white);
  }

  void _playJackpot(BuildContext context) {
    jackpotResult = false;
    _showJackpotDialog(context);
  }

  void _playAntiJackpot(BuildContext context) {
    antiJackpotResult = false;
    _showAntiJackpotDialog(context);
  }

  void _showFindResult(BuildContext context, String imagePath, String message,
      String coin, Color textColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return Center(
          child: Column(
            children: [
              const Gap(213),
              Image.asset(imagePath, width: 200, height: 200),
              Text(
                message,
                style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                coin,
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        );
      },
    );
  }

  void _showJackpotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return const Center(
          child: Text(
            'Jackpot Game',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700),
          ),
        );
      },
    );
  }

  void _showAntiJackpotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return const Center(
          child: Text(
            'Anti-Jackpot Game',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700),
          ),
        );
      },
    );
  }
}
