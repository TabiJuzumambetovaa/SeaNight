import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../utils/game.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_icon.dart';
import '../utils/app_pngs.dart';

class HeaderInfoCurrentBalanceClose extends StatelessWidget {
  const HeaderInfoCurrentBalanceClose({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppIcon(
          AppIcons.info,
          size: 36,
          color: AppColors.white,
        ),
        const Gap(105),
        Text(
          ' ${game.currentBalance}',
          style: AppFonts.s28w600.copyWith(color: AppColors.white),
        ),
        Image.asset(
          AppPngs.oneCoins,
          width: 32,
          height: 32,
        ),
        const Gap(90),
        const AppIcon(AppIcons.close,
            size: 20, color: AppColors.white),
      ],
    );
  }
}

