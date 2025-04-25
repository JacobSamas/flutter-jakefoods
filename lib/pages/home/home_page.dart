import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _cart = [];

  final categories = [
    {'name': 'Pizza', 'icon': Icons.local_pizza, 'color': Colors.orange[100]},
    {'name': 'Indian', 'icon': Icons.rice_bowl, 'color': Colors.deepOrange[100]},
    {'name': 'Chinese', 'icon': Icons.ramen_dining, 'color': Colors.red[100]},
    {'name': 'Desserts', 'icon': Icons.icecream, 'color': Colors.pink[100]},
    {'name': 'Burgers', 'icon': Icons.lunch_dining, 'color': Colors.yellow[100]},
  ];

  final dishes = [
    {
      'name': 'Paneer Butter Masala',
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
      'price': 220.0,
      'desc': 'Rich, creamy, and full of flavor.',
    },
    {
      'name': 'Veg Biryani',
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
      'price': 180.0,
      'desc': 'Aromatic rice with veggies and spices.',
    },
    {
      'name': 'Pizza Margherita',
      'image': 'https://images.unsplash.com/photo-1542281286-9e0a16bb7366?auto=format&fit=crop&w=400&q=80',
      'price': 299.0,
      'desc': 'Classic cheese and tomato pizza.',
    },
    {
      'name': 'Spring Rolls',
      'image': 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80',
      'price': 120.0,
      'desc': 'Crispy and delicious Chinese snack.',
    },
    {
      'name': 'Chocolate Lava Cake',
      'image': 'https://images.unsplash.com/photo-1505250469679-203ad9ced0cb?auto=format&fit=crop&w=400&q=80',
      'price': 140.0,
      'desc': 'Warm cake with gooey chocolate center.',
    },
  ];

  void _addToCart(Map<String, dynamic> dish) {
    final index = _cart.indexWhere((item) => item['name'] == dish['name']);
    setState(() {
      if (index != -1) {
        _cart[index]['quantity'] += 1;
      } else {
        _cart.add({
          ...dish,
          'quantity': 1,
        });
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${dish['name']} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JakeFoods'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                    ),
                    builder: (_) => _cart.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Center(child: Text('Your cart is empty.')),
                          )
                        : ListView(
                            padding: const EdgeInsets.all(18),
                            shrinkWrap: true,
                            children: [
                              const Text('Cart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              const SizedBox(height: 12),
                              ..._cart.map((item) => ListTile(
                                    title: Text(item['name']),
                                    subtitle: Text('x${item['quantity']}'),
                                    trailing: Text('₹${(item['price'] * item['quantity']).toStringAsFixed(0)}'),
                                  )),
                              const Divider(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Total: ₹${_cart.fold<double>(0, (sum, item) => sum + (item['price'] * item['quantity'] as double)).toStringAsFixed(0)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange),
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_cart.fold(0, (sum, item) => sum + (item['quantity'] as int))}',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food or restaurants...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // Categories
              const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, i) => const SizedBox(width: 16),
                  itemBuilder: (context, i) => ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Material(
                      color: categories[i]['color'] as Color?,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(categories[i]['icon'] as IconData, color: Colors.deepOrange, size: 24),
                              const SizedBox(width: 7),
                              Flexible(
                                child: Text(
                                  categories[i]['name'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              // Popular/recommended dishes
              const Text('Popular Dishes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dishes.length,
                separatorBuilder: (context, i) => const SizedBox(height: 16),
                itemBuilder: (context, i) {
                  final dish = dishes[i];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              dish['image'] as String,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dish['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 6),
                                Text(dish['desc'] as String, style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('₹${(dish['price'] as double).toStringAsFixed(0)}', style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 17)),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => _addToCart(dish),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                  elevation: 0,
                                ),
                                child: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
