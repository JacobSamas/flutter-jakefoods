import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          SwitchListTile(
            value: true,
            onChanged: (v) {},
            activeColor: Colors.deepOrange,
            title: const Text('Push Notifications'),
          ),
          const Divider(),
          SwitchListTile(
            value: false,
            onChanged: (v) {},
            activeColor: Colors.deepOrange,
            title: const Text('Dark Mode'),
          ),
        ],
      ),
    );
  }
}
