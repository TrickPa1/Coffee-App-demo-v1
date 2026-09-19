import 'package:coffe_shop/components/coffee_tile.dart';
import 'package:coffe_shop/models/coffee.dart';
import 'package:coffe_shop/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //remover item
  void removeFromCart(Coffee coffee){
    Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, index) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              // cabeçalho
              Text(
                'Teu Carrinho',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              // lista dos cafés
              Expanded(
                child: ListView.builder(
                  itemCount: value.userCart.length,
                  itemBuilder: (context, index){
                    // Obter individual os items
                    Coffee eachCoffee = value.userCart[index];

                    // retorna coffee tile
                    return CoffeeTile(
                      coffee: eachCoffee, 
                      onPressed: () => removeFromCart(eachCoffee), 
                      icon: Icon(Icons.delete),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}