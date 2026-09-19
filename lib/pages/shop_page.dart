import 'package:coffe_shop/components/coffee_tile.dart';
import 'package:coffe_shop/models/coffee.dart';
import 'package:coffe_shop/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  // adiciona ao carrinho
  void addToCart(Coffee coffee){
    Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);

    // avisa ao adicionar item
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Café adicionado com sucesso no carrinho."),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(builder: (context, value, child) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              // mensagem do topo
              Text(
                "Como gostaria do seu café?",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 25,),

              //lista dos cafés
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index) {
                    // obter cafe individualmente
                    Coffee eachCoffee = value.coffeeShop[index];

                    // retornar o cafe
                    return CoffeeTile(
                      coffee: eachCoffee,
                      onPressed: () => addToCart(eachCoffee),
                      icon: Icon(Icons.add),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}