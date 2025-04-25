import 'package:flutter/material.dart';
import '../../components/restaurant_card.dart';
import '../../utils/dummy_data.dart';

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
              // TODO: Navigate to detail page
            },
          );
        },
      ),
    );
  }
}
