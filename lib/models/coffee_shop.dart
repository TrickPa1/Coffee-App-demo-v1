import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {
  // Lista do menu com imagens de alta qualidade da Web
  final List<Coffee> _shop = [
    Coffee(
      id: '1',
      name: 'Espresso Intenso',
      price: 120.0,
      imagePath: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500&q=80',
      description: 'Café preto encorpado e rico em aroma, perfeito para começar o dia.',
      category: 'Quentes',
    ),
    Coffee(
      id: '2',
      name: 'Cappuccino Cremoso',
      price: 180.0,
      imagePath: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500&q=80',
      description: 'Combinação clássica de espresso, leite vaporizado e espuma cremosa.',
      category: 'Quentes',
    ),
    Coffee(
      id: '3',
      name: 'Iced Latte Caramelo',
      price: 220.0,
      imagePath: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
      description: 'Café gelado refrescante com leite, baunilha e calda de caramelo.',
      category: 'Gelados',
    ),
    Coffee(
      id: '4',
      name: 'Mocha de Chocolate',
      price: 200.0,
      imagePath: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?w=500&q=80',
      description: 'Espresso misturado com calda de chocolate denso e leite vaporizado.',
      category: 'Especiais',
    ),
  ];

  final List<Coffee> _userCart = [];
  final List<Order> _orderHistory = [];

  // Getters
  List<Coffee> get coffeeShop => _shop;
  List<Coffee> get userCart => _userCart;
  List<Order> get orderHistory => _orderHistory;
  List<Coffee> get favoriteCoffees => _shop.where((c) => c.isFavorite).toList();

  int get totalCartCount => _userCart.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotalAmount {
    return _userCart.fold(0.0, (sum, item) => sum + (item.finalPrice * item.quantity));
  }

  double calculateTotal() => cartTotalAmount;

  void clearCart() {
    _userCart.clear();
    notifyListeners();
  }

  void toggleFavorite(Coffee coffee) {
    coffee.isFavorite = !coffee.isFavorite;
    notifyListeners();
  }

  void addItemToCart(Coffee coffee) {
    int index = _userCart.indexWhere((item) =>
        item.id == coffee.id &&
        item.selectedSize == coffee.selectedSize &&
        item.selectedMilk == coffee.selectedMilk);

    if (index >= 0) {
      _userCart[index].quantity += coffee.quantity;
    } else {
      _userCart.add(coffee.copyWith());
    }
    notifyListeners();
  }

  void removeItemFromCart(Coffee coffee) {
    _userCart.removeWhere((item) =>
        item.id == coffee.id &&
        item.selectedSize == coffee.selectedSize &&
        item.selectedMilk == coffee.selectedMilk);
    notifyListeners();
  }

  void incrementCartItem(Coffee item) {
    item.quantity++;
    notifyListeners();
  }

  void decrementCartItem(Coffee item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeItemFromCart(item);
    }
    notifyListeners();
  }

  void placeOrder({required String paymentMethod, required String deliveryOption}) {
    if (_userCart.isEmpty) return;

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString().substring(5),
      items: _userCart
          .map((c) => OrderItem(
                coffee: c,
                quantity: c.quantity,
                size: c.selectedSize,
                milk: c.selectedMilk,
              ))
          .toList(),
      totalAmount: cartTotalAmount,
      date: DateTime.now(),
      paymentMethod: paymentMethod,
      deliveryOption: deliveryOption,
    );

    _orderHistory.insert(0, order);
    _userCart.clear();
    notifyListeners();
  }
}