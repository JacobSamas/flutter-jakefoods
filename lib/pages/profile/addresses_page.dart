import 'package:flutter/material.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demoAddresses = [
      '221B Baker Street, London',
      '742 Evergreen Terrace, Springfield',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Addresses'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: demoAddresses.length + 1,
        separatorBuilder: (context, i) => const Divider(),
        itemBuilder: (context, i) {
          if (i == demoAddresses.length) {
            return ListTile(
              leading: const Icon(Icons.add_location_alt, color: Colors.deepOrange),
              title: const Text('Add New Address'),
              onTap: () {
                // TODO: Implement add address
              },
            );
          }
          return ListTile(
            leading: const Icon(Icons.location_on, color: Colors.deepOrange),
            title: Text(demoAddresses[i]),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                // TODO: Edit address
              },
            ),
          );
        },
      ),
    );
  }
}
