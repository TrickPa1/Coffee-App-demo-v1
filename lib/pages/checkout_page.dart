import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_shop.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPayment = 'M-Pesa';
  String selectedDelivery = 'Delivery';
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // Taxa fixa de entrega para Delivery
  final double deliveryFee = 100.0;

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _confirmAndPay(CoffeeShop coffeeShop) {
    // 1. Validação de Endereço se for Delivery
    if (selectedDelivery == 'Delivery' && addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, informe o endereço de entrega.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 2. Validação de Número M-Pesa / e-Mola
    if (selectedPayment == 'M-Pesa' || selectedPayment == 'e-Mola') {
      String phone = phoneController.text.trim();
      
      if (phone.length < 9) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Introduza um número de telefone válido com 9 dígitos.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedPayment == 'M-Pesa' && !(phone.startsWith('84') || phone.startsWith('85'))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('M-Pesa aceita apenas números Vodacom (84 ou 85).'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedPayment == 'e-Mola' && !(phone.startsWith('86') || phone.startsWith('87'))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('e-Mola aceita apenas números Movitel (86 ou 87).'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    // 3. Sucesso - Processar Pedido
    coffeeShop.placeOrder(
      paymentMethod: selectedPayment,
      deliveryOption: selectedDelivery,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Pedido Confirmado! 🎉'),
        content: Text(
          selectedDelivery == 'Delivery'
              ? 'O seu pedido foi recebido e será entregue em breve no endereço indicado.'
              : 'O seu pedido foi recebido e estará disponível para levantamento na loja.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha dialog
              Navigator.pop(context); // Volta da página de checkout
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coffeeShop = Provider.of<CoffeeShop>(context);
    final theme = Theme.of(context);

    // Cálculo do total incluindo taxa de entrega quando aplicável
    double currentDeliveryFee = selectedDelivery == 'Delivery' ? deliveryFee : 0.0;
    double grandTotal = coffeeShop.cartTotalAmount + currentDeliveryFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar Pedido'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- OPÇÕES DE ENTREGA ---
            const Text('Opção de Entrega', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Delivery (+100 MT)')),
                    selected: selectedDelivery == 'Delivery',
                    onSelected: (val) => setState(() => selectedDelivery = 'Delivery'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Levantar na Loja (Grátis)')),
                    selected: selectedDelivery == 'Takeaway',
                    onSelected: (val) => setState(() => selectedDelivery = 'Takeaway'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Campo de endereço (Apenas se for Delivery)
            if (selectedDelivery == 'Delivery') ...[
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Endereço de Entrega (Bairro, Rua, Nº Casa)',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // --- MÉTODO DE PAGAMENTO ---
            const Text('Método de Pagamento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            RadioListTile(
              title: const Text('M-Pesa (Vodacom - 84 / 85)'),
              value: 'M-Pesa',
              groupValue: selectedPayment,
              onChanged: (val) => setState(() {
                selectedPayment = val.toString();
                phoneController.clear();
              }),
            ),
            RadioListTile(
              title: const Text('e-Mola (Movitel - 86 / 87)'),
              value: 'e-Mola',
              groupValue: selectedPayment,
              onChanged: (val) => setState(() {
                selectedPayment = val.toString();
                phoneController.clear();
              }),
            ),
            RadioListTile(
              title: const Text('Cartão de Crédito/Débito'),
              value: 'Cartão',
              groupValue: selectedPayment,
              onChanged: (val) => setState(() => selectedPayment = val.toString()),
            ),
            RadioListTile(
              title: Text(selectedDelivery == 'Delivery' ? 'Pagamento na Entrega' : 'Pagamento na Loja'),
              value: 'Dinheiro',
              groupValue: selectedPayment,
              onChanged: (val) => setState(() => selectedPayment = val.toString()),
            ),
            const SizedBox(height: 16),

            // Input dinâmico de telefone conforme a carteira móvel
            if (selectedPayment == 'M-Pesa') ...[
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 9,
                decoration: const InputDecoration(
                  labelText: 'Número M-Pesa (Ex: 841234567 ou 851234567)',
                  prefixIcon: Icon(Icons.phone_android, color: Colors.red),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 20),
            ],

            if (selectedPayment == 'e-Mola') ...[
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 9,
                decoration: const InputDecoration(
                  labelText: 'Número e-Mola (Ex: 861234567 ou 871234567)',
                  prefixIcon: Icon(Icons.phone_android, color: Colors.orange),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 20),
            ],

            // --- RESUMO DA COMPRA ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal:'),
                      Text('${coffeeShop.cartTotalAmount.toStringAsFixed(2)} MT'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Taxa de Entrega:'),
                      Text(
                        selectedDelivery == 'Delivery' ? '+ 100.00 MT' : '0.00 MT (Grátis)',
                        style: TextStyle(
                          color: selectedDelivery == 'Delivery' ? Colors.black : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total a Pagar:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        '${grandTotal.toStringAsFixed(2)} MT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Botão de Confirmação
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _confirmAndPay(coffeeShop),
                child: const Text('Confirmar e Pagar', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}