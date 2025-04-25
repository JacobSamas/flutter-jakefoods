import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../models/menu_item.dart' as menu_model;
import '../../models/cart_model.dart';
import 'package:provider/provider.dart';
import '../cart_page.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;
  final List<menu_model.MenuItem> menu;

  const RestaurantDetailPage({super.key, required this.restaurant, required this.menu});

  @override
  Widget build(BuildContext context) {
    // Dummy description and reviews
    final description = 'Welcome to ${restaurant.name}! Enjoy mouth-watering dishes in a cozy ambience. Our chefs use the freshest ingredients to bring you the best of ${restaurant.cuisine} cuisine. Perfect for family dinners and quick bites!';
    final reviews = [
      {
        'user': 'Amit',
        'rating': 5.0,
        'comment': 'Amazing food and quick delivery! Highly recommended.'
      },
      {
        'user': 'Priya',
        'rating': 4.5,
        'comment': 'Loved the biryani and paneer dishes. Will order again!'
      },
      {
        'user': 'Rahul',
        'rating': 4.0,
        'comment': 'Good taste, nice packaging, and friendly staff.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                restaurant.imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            // --- Photo Gallery Carousel ---
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      restaurant.imageUrl,
                      width: 140,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/paneer.jpg',
                      width: 140,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/biryani.jpg',
                      width: 140,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/pizza.jpg',
                      width: 140,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            // --- Restaurant Info Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.deepOrange, size: 20),
                      const SizedBox(width: 8),
                      Text('Open: 11am – 11pm', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.deepOrange, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          restaurant.location + ', Bengaluru',
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.map, color: Colors.blue),
                        onPressed: () {}, // Could open Google Maps
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.deepOrange, size: 20),
                      const SizedBox(width: 8),
                      Text('+91 98765 43210', style: TextStyle(fontSize: 15)),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () {}, // Could launch phone dialer
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.deepOrange, size: 18),
                      const SizedBox(width: 4),
                      Text(restaurant.rating.toString()),
                      const SizedBox(width: 12),
                      Text(restaurant.cuisine),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(restaurant.location, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: Chip(
                          label: Text('Pure Veg', style: TextStyle(color: Colors.green[700])),
                          backgroundColor: Colors.green[50],
                          avatar: Icon(Icons.eco, color: Colors.green[700], size: 18),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Chip(
                          label: const Text('Delivery: 30 min'),
                          avatar: const Icon(Icons.delivery_dining, size: 18),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Chip(
                          label: const Text('Free Delivery'),
                          avatar: const Icon(Icons.local_offer, size: 18, color: Colors.deepOrange),
                          backgroundColor: Colors.orange[50],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Special Offer: Get 20% off on all orders above ₹500! Use code JAKEFOODS.',
                      style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // --- New Description Section ---
                  const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 20),
                  const Text('Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final item = menu[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.name),
                    subtitle: Text(item.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('₹${item.price.toStringAsFixed(0)}'),
                        const SizedBox(width: 8),
                        Consumer<CartModel>(
                          builder: (context, cart, child) {
                            final count = cart.items[item] ?? 0;
                            return Row(
                              children: [
                                if (count > 0) ...[
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, size: 20),
                                    onPressed: () => cart.remove(item),
                                  ),
                                  Text('$count', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                                IconButton(
                                  icon: const Icon(Icons.add_circle, color: Colors.deepOrange, size: 20),
                                  onPressed: () => cart.add(item),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // --- Reviews Section (now below menu) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, idx) {
                final r = reviews[idx] as Map<String, Object>;
                return ListTile(
                  leading: CircleAvatar(child: Text((r['user'] as String)[0])),
                  title: Row(
                    children: [
                      Text(r['user'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Icon(Icons.star, color: Colors.deepOrange, size: 16),
                      Text((r['rating'] as double).toString()),
                    ],
                  ),
                  subtitle: Text(r['comment'] as String),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
