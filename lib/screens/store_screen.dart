import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
           gradient: LinearGradient(
              colors: [AppColors.lagoon, AppColors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        ),
      ),
    );
  }
}