class Coffee {
  final String name;
  final double price;
  final String imagePath;
  final String description; 
  int quantity;

  Coffee({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description, 
    this.quantity = 1,
  });

  String get formattedPrice => '${price.toStringAsFixed(2)} MT';
}