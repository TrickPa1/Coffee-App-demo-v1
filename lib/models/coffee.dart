class Coffee {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final String description;
  final String category; 
  bool isFavorite;
  int quantity;
  
  // Opções personalizadas selecionadas pelo cliente
  String selectedSize;
  String selectedMilk;

  Coffee({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    this.category = 'Quentes',
    this.isFavorite = false,
    this.quantity = 1,
    this.selectedSize = 'Médio',
    this.selectedMilk = 'Integral',
  });

  // Cálculo de preço baseado no tamanho
  double get finalPrice {
    double base = price;
    if (selectedSize == 'Grande') base += 30;
    if (selectedSize == 'Pequeno') base -= 15;
    return base;
  }

  String get formattedPrice => '${finalPrice.toStringAsFixed(2)} MT';

  // Copiar objeto mantendo imutabilidade quando necessário
  Coffee copyWith({
    String? id,
    String? name,
    double? price,
    String? imagePath,
    String? description,
    String? category,
    bool? isFavorite,
    int? quantity,
    String? selectedSize,
    String? selectedMilk,
  }) {
    return Coffee(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedMilk: selectedMilk ?? this.selectedMilk,
    );
  }
}

class OrderItem {
  final Coffee coffee;
  final int quantity;
  final String size;
  final String milk;

  OrderItem({
    required this.coffee,
    required this.quantity,
    required this.size,
    required this.milk,
  });

  double get totalPrice => coffee.finalPrice * quantity;
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalAmount;
  final DateTime date;
  final String paymentMethod;
  final String deliveryOption; 
  String status; 

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.paymentMethod,
    required this.deliveryOption,
    this.status = 'Em Preparação',
  });
}