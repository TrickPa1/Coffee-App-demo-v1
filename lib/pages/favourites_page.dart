import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_shop.dart';
import '../components/coffee_card.dart';
import 'coffee_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) {
        final favorites = value.favoriteCoffees;

        if (favorites.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Nenhum café favorito ainda', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Meus Favoritos'), centerTitle: true),
          body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final coffee = favorites[index];
              return CoffeeCard(
                coffee: coffee,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoffeeDetailPage(coffee: coffee)),
                  );
                },
                onAddPressed: () {
                  value.addItemToCart(coffee);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${coffee.name} adicionado ao carrinho!')),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}