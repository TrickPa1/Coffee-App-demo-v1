import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_shop.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override;
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) {
        if (value.orderHistory.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Nenhum pedido efetuado ainda.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Meus Pedidos'), centerTitle: true),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: value.orderHistory.length,
            itemBuilder: (context, index) {
              final order = value.orderHistory[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pedido #${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Chip(
                            label: Text(order.status, style: const TextStyle(fontSize: 12, color: Colors.white)),
                            backgroundColor: Colors.orange,
                          ),
                        ],
                      ),
                      const Divider(),
                      ...order.items.map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.quantity}x ${item.coffee.name} (${item.size}, ${item.milk})'),
                                Text('${item.totalPrice.toStringAsFixed(2)} MT'),
                              ],
                            ),
                          )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pagamento: ${order.paymentMethod}'),
                          Text(
                            'Total: ${order.totalAmount.toStringAsFixed(2)} MT',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}