import 'package:coffe_shop/components/my_bottom_nav_bar.dart';
import 'package:coffe_shop/pages/cart_page.dart';
import 'package:coffe_shop/pages/settings_page.dart';
import 'package:coffe_shop/pages/shop_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //barra de navegação
  int _selectedIndex = 0;
  void navigateBottomBar(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  //paginas 
  final List<Widget> _pages = [
    // pagina da loja
    ShopPage(),

    // pagina do carrinho
    CartPage(),

    //pagina de definições
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}