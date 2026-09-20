import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/coffee_card.dart';
import '../models/coffee.dart';
import '../models/coffee_shop.dart';
import 'coffee_detail_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final PageController _bannerController = PageController();

  // Banners promocionais
  final List<Map<String, String>> _banners = [
    {
      'title': 'Desconto Especial!',
      'subtitle': '20% OFF em Cappuccinos esta semana',
      'icon': '☕',
    },
    {
      'title': 'Novo no Menu',
      'subtitle': 'Experimente o nosso Café Gelado Especial',
      'icon': '🧊',
    },
    {
      'title': 'Hora do Café',
      'subtitle': 'Cafés selecionados com entrega grátis',
      'icon': '🛵',
    },
  ];

  void addToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${coffee.name} foi adicionado ao carrinho!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void openDetailPage(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeDetailPage(coffee: coffee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              // Título de Boas-vindas
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Encontre o seu café perfeito ☕',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Carrossel de Banners
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 130,
                  child: PageView.builder(
                    controller: _bannerController,
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      final banner = _banners[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    banner['title']!,
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    banner['subtitle']!,
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimary.withOpacity(0.85),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              banner['icon']!,
                              style: const TextStyle(fontSize: 40),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Cabeçalho dos Produtos
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    'Menu de Cafés',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Grelha de Cafés (Grid Layout)
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Coffee eachCoffee = value.coffeeShop[index];
                    return CoffeeCard(
                      coffee: eachCoffee,
                      onTap: () => openDetailPage(eachCoffee),
                      onAddPressed: () => addToCart(eachCoffee),
                    );
                  },
                  childCount: value.coffeeShop.length,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}