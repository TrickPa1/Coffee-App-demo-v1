import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {
  final List<Coffee> _shop = [
    Coffee(
      name: 'Preto Forte',
      price: 200.0,
      imagePath: 'assets/images/black.png',
      description: 'Café preto encorpado e rico em aroma, perfeito para começar o dia com energia.',
    ),
    Coffee(
      name: 'Espresso',
      price: 300.0,
      imagePath: 'assets/images/espresso.jpeg',
      description: 'Dose concentrada de puro café arábica com uma crema aveludada e intensa.',
    ),
    Coffee(
      name: 'Cappuccino',
      price: 275.0,
      imagePath: 'assets/images/cappucino.jpeg',
      description: 'Mistura harmoniosa de espresso, leite vaporizado e uma generosa camada de espuma de leite.',
    ),
    Coffee(
      name: 'Café Gelado',
      price: 280.0,
      imagePath: 'assets/images/ice_coffe.jpeg',
      description: 'Refrescante infusão de café servido com gelo e um toque suave de baunilha.',
    ),
    Coffee(
      name: 'Latte',
      price: 350.0,
      imagePath: 'assets/images/latte.jpeg',
      description: 'Espresso suave combinado com uma grande quantidade de leite cremoso vaporizado.',
    ),
  ];

  final List<Coffee> _userCart = [];

  List<Coffee> get coffeeShop => _shop;
  List<Coffee> get userCart => _userCart;

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
          description: coffee.description,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

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

  void clearCart() {
    _userCart.clear();
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0;
    for (var item in _userCart) {
      total += item.price * item.quantity;
    }
    return total;
  }
}