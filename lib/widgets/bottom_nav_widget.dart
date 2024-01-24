import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  void Function(int)? onHandleChangeTab;
  int routeIndex;
  BottomNavBar(
      {super.key, required this.onHandleChangeTab, required this.routeIndex});

  @override
  Widget build(BuildContext context) {
    return GNav(
      color: const Color.fromRGBO(185, 178, 178, 1),
      mainAxisAlignment: MainAxisAlignment.center,
      tabBackgroundColor: const Color.fromRGBO(218, 215, 215, 1),
      tabBorderRadius: 8,
      padding: const EdgeInsets.all(8),
      onTabChange: (value) => onHandleChangeTab!(value),
      selectedIndex: routeIndex,
      tabs: const [
        GButton(
          icon: Icons.home,
          text: 'Home',
        ),
        GButton(
          icon: Icons.shopping_cart,
          text: 'Cart',
        ),
      ],
    );
  }
}
