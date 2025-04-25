import 'package:flutter/material.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> demoItems;

  @override
  void initState() {
    super.initState();
    demoItems = [
      {
        'name': 'Paneer Butter Masala',
        'price': 220.0,
        'quantity': 1,
        'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=80&q=80',
      },
      {
        'name': 'Veg Biryani',
        'price': 180.0,
        'quantity': 2,
        'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=80&q=80',
      },
    ];
  }

  double get total => demoItems.fold(0.0, (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int));

  void increment(int index) {
    setState(() {
      demoItems[index]['quantity'] += 1;
    });
  }

  void decrement(int index) {
    setState(() {
      if (demoItems[index]['quantity'] > 1) {
        demoItems[index]['quantity'] -= 1;
      } else {
        demoItems.removeAt(index);
      }
    });
  }

  void goToCheckout() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CheckoutPage(total: total),
      ),
    );
    if (result == 'order_placed') {
      setState(() {
        demoItems.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text('Your Cart', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: demoItems.isEmpty
                ? Center(
                    child: Text('Your cart is empty.', style: Theme.of(context).textTheme.titleMedium),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: demoItems.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final item = demoItems[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  item['image'] as String,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                    const SizedBox(height: 6),
                                    Text('₹${(item['price'] as double).toStringAsFixed(0)}', style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, size: 22),
                                    onPressed: () => decrement(index),
                                    splashRadius: 18,
                                    color: Colors.grey.shade700,
                                  ),
                                  Text('${item['quantity']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle, color: Colors.deepOrange, size: 22),
                                    onPressed: () => increment(index),
                                    splashRadius: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -3),
                ),
              ],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 15, color: Colors.grey)),
                    Text('₹${total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: demoItems.isEmpty
                      ? null
                      : goToCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    elevation: 1,
                  ),
                  icon: const Icon(Icons.shopping_bag_outlined, size: 22),
                  label: const Text('Checkout', style: TextStyle(fontSize: 17)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
