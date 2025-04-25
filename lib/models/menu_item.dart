class MenuItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  MenuItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

final Map<String, List<MenuItem>> dummyMenu = {
  '1': [
    MenuItem(
      id: 'm1',
      name: 'Paneer Butter Masala',
      imageUrl: 'assets/images/paneer.jpg',
      price: 220.0,
      description: 'Creamy cottage cheese curry.',
    ),
    MenuItem(
      id: 'm2',
      name: 'Veg Biryani',
      imageUrl: 'assets/images/biryani.jpg',
      price: 180.0,
      description: 'Aromatic rice with veggies.',
    ),
  ],
  '2': [
    MenuItem(
      id: 'm3',
      name: 'Grilled Chicken',
      imageUrl: 'assets/images/grilled_chicken.jpg',
      price: 250.0,
      description: 'Juicy grilled chicken breast.',
    ),
  ],
  '3': [
    MenuItem(
      id: 'm4',
      name: 'Margherita Pizza',
      imageUrl: 'assets/images/pizza.jpg',
      price: 300.0,
      description: 'Classic cheese pizza.',
    ),
  ],
};
