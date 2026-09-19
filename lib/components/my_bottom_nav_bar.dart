import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        color: Color(0xFFA78D78),
        activeColor: Color(0xFF6E473B),
        tabBackgroundColor: Color(0xFFFBE4D8),
        tabBorderRadius: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          GButton(
            icon: Icons.coffee,
            text: 'Loja',
          ),
          GButton(
            icon: Icons.shopping_bag_outlined,
            text: 'Carrinho',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Definições',
          ),
        ],
      ),
    );
  }
}