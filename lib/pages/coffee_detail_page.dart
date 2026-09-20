import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee.dart';
import '../models/coffee_shop.dart';

class CoffeeDetailPage extends StatefulWidget {
  final Coffee coffee;

  const CoffeeDetailPage({super.key, required this.coffee});

  @override
  State<CoffeeDetailPage> createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage> {
  late String selectedSize;
  late String selectedMilk;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.coffee.selectedSize;
    selectedMilk = widget.coffee.selectedMilk;
  }

  Widget _buildDetailImage(ThemeData theme) {
    bool isNetworkImage = widget.coffee.imagePath.startsWith('http');

    if (isNetworkImage) {
      return Image.network(
        widget.coffee.imagePath,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 220,
            color: theme.colorScheme.surface,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          height: 220,
          color: theme.colorScheme.surface,
          child: const Icon(Icons.coffee, size: 80),
        ),
      );
    } else {
      return Image.asset(
        widget.coffee.imagePath,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 220,
          color: theme.colorScheme.surface,
          child: const Icon(Icons.coffee, size: 80),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coffeeShop = Provider.of<CoffeeShop>(context);

    // Cálculo dinâmico do preço com base no tamanho selecionado
    double currentPrice = widget.coffee.price;
    if (selectedSize == 'Grande') currentPrice += 30;
    if (selectedSize == 'Pequeno') currentPrice -= 15;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffee.name),
        actions: [
          IconButton(
            icon: Icon(
              widget.coffee.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.coffee.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              coffeeShop.toggleFavorite(widget.coffee);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animação Hero com suporte a URL / Asset
                  Hero(
                    tag: widget.coffee.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _buildDetailImage(theme),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    widget.coffee.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.coffee.description,
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Escolha do Tamanho
                  const Text('Tamanho', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Pequeno', 'Médio', 'Grande'].map((size) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(size),
                          selected: selectedSize == size,
                          onSelected: (val) => setState(() => selectedSize = size),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Escolha do Leite
                  const Text('Tipo de Leite', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Integral', 'Desnatado', 'Sem Lactose', 'Aveia'].map((milk) {
                      return ChoiceChip(
                        label: Text(milk),
                        selected: selectedMilk == milk,
                        onSelected: (val) => setState(() => selectedMilk = milk),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Painel Inferior de Compra
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Preço Total', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      '${currentPrice.toStringAsFixed(2)} MT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    final itemToAdd = widget.coffee.copyWith(
                      selectedSize: selectedSize,
                      selectedMilk: selectedMilk,
                    );
                    coffeeShop.addItemToCart(itemToAdd);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.coffee.name} adicionado ao carrinho!')),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}