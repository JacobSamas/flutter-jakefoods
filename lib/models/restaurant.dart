class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final String location;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.location,
  });
}

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
}
