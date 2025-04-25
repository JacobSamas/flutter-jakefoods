import 'package:flutter/material.dart';
import '../../components/restaurant_card.dart';
import '../../utils/dummy_data.dart';
import '../../models/menu_item.dart';
import 'restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: ListView.builder(
        itemCount: dummyRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = dummyRestaurants[index];
          return RestaurantCard(
            restaurant: restaurant,
            onTap: () {
              final menu = dummyMenu[restaurant.id] ?? [];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(
                    restaurant: restaurant,
                    menu: menu,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
