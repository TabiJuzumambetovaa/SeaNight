import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sea_night/screens/game_screen.dart';
import 'package:flutter_sea_night/screens/settings.dart';
import 'package:flutter_sea_night/screens/store_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyExampleState createState() => _MyExampleState();
}

class _MyExampleState extends State<HomePage> {
  int _selectedIndex = 0; 
  final List<Widget> _widgetOptions = [
    const GamePage(),
    const StoreScreen(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: Colors.white,
        unSelectedColor: Colors.grey,
        backgroundColor: const Color(0xff0066C5),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.top,
        // gradient: LinearGradient(
        //   colors: kGradients,
        // ),

        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Game',
            icon: Icons.gamepad_outlined,
          ),
          CustomBottomBarItems(
            label: 'Store',
            icon: Icons.storefront,
          ),
          CustomBottomBarItems(
            label: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
