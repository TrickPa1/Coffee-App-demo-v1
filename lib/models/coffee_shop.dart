import 'package:coffe_shop/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeShop extends ChangeNotifier{

  // lista de cafés a venda
  final List<Coffee> _shop = [
    // Café Preto
    Coffee(
      name: 'Preto Forte', 
      price: "200", 
      imagePath: 'assets/images/black.png',
    ),

    // espresso
    Coffee(
      name: 'Espresso', 
      price: "300", 
      imagePath: "assets/images/espresso.jpeg",
    ),

    // cappucino
    Coffee(
      name: 'Cappucino', 
      price: "275", 
      imagePath: "assets/images/cappucino.jpeg",
    ),

    // caffe gelado
    Coffee(
      name: 'Gelado', 
      price: "280", 
      imagePath: "assets/images/ice_coffe.jpeg",
    ),

    // latte
    Coffee(
      name: 'Latte', 
      price: "350", 
      imagePath: "assets/images/latte.jpeg",
    ),
  ];

  // carrinho
  List<Coffee> _userCart = [];
  
  // obter carrinho
  List<Coffee> get coffeeShop => _shop;

  // obter lista de cafés
  List<Coffee> get userCart => _userCart;

  // adicionar item no carrinho
  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  // remover item do carrinho
  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }

}