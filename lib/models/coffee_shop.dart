import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {
  // Lista de cafés disponíveis
  final List<Coffee> _shop = [
    Coffee(
      name: 'Preto Forte',
      price: 200.0,
      imagePath: 'assets/images/black.png',
    ),
    Coffee(
      name: 'Espresso',
      price: 300.0,
      imagePath: 'assets/images/espresso.jpeg',
    ),
    Coffee(
      name: 'Cappuccino',
      price: 275.0,
      imagePath: 'assets/images/cappucino.jpeg',
    ),
    Coffee(
      name: 'Café Gelado',
      price: 280.0,
      imagePath: 'assets/images/ice_coffe.jpeg',
    ),
    Coffee(
      name: 'Latte',
      price: 350.0,
      imagePath: 'assets/images/latte.jpeg',
    ),
  ];

  final List<Coffee> _userCart = [];

  // Getters
  List<Coffee> get coffeeShop => _shop;
  List<Coffee> get userCart => _userCart;

  // Adicionar item ao carrinho
  void addItemToCart(Coffee coffee) {
    int index = _userCart.indexWhere((item) => item.name == coffee.name);
    
    if (index >= 0) {
      _userCart[index].quantity++;
    } else {
      _userCart.add(
        Coffee(
          name: coffee.name,
          price: coffee.price,
          imagePath: coffee.imagePath,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // Remover ou decrementar item do carrinho
  void removeItemFromCart(Coffee coffee) {
    int index = _userCart.indexWhere((item) => item.name == coffee.name);
    
    if (index >= 0) {
      if (_userCart[index].quantity > 1) {
        _userCart[index].quantity--;
      } else {
        _userCart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Limpar carrinho
  void clearCart() {
    _userCart.clear();
    notifyListeners();
  }

  // Calcular valor total do carrinho
  double calculateTotal() {
    double total = 0;
    for (var item in _userCart) {
      total += item.price * item.quantity;
    }
    return total;
  }
}