import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy cart items for UI demo
    final demoItems = [
      {
        'name': 'Paneer Butter Masala',
        'price': 220.0,
        'quantity': 1,
      },
      {
        'name': 'Veg Biryani',
        'price': 180.0,
        'quantity': 2,
      },
    ];
    final total = demoItems.fold(0.0, (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int));

    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        children: [
          const SizedBox(height: 18), // Extra space for dynamic island/notch
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: demoItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = demoItems[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.fastfood, size: 40, color: Colors.deepOrange),
                    title: Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('₹${(item['price'] as double).toStringAsFixed(0)} x ${item['quantity']}'),
                    trailing: SizedBox(
                      width: 90,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: IconButton(
                              icon: const Icon(Icons.remove_circle_outline, size: 22),
                              onPressed: () {},
                              splashRadius: 18,
                            ),
                          ),
                          Flexible(
                            child: Text('${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: const Icon(Icons.add_circle, color: Colors.deepOrange, size: 22),
                              onPressed: () {},
                              splashRadius: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    Text('₹${total.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checkout not implemented.')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                  label: const Text('Checkout', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
