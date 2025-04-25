import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'order_history_page.dart';
import 'addresses_page.dart';
import 'settings_page.dart';
import 'login_page.dart';
import '../../models/user_profile.dart';
import '../../utils/local_storage.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await LocalStorage.loadProfile();
    setState(() {
      _profile = profile;
      _loading = false;
    });
  }

  void _navigate(BuildContext context, Widget page) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
    // If profile was edited, reload
    if (result == true) {
      _loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final profile = _profile!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        children: [
          // Profile Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.deepOrange.shade100,
                    backgroundImage: profile.avatarPath != null ? FileImage(File(profile.avatarPath!)) : null,
                    child: profile.avatarPath == null
                        ? Text(
                            profile.name.isNotEmpty ? profile.name[0] : 'J',
                            style: const TextStyle(fontSize: 30, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(height: 5),
                        Text(profile.email, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.deepOrange),
                    onPressed: () {
                      _navigate(context, const EditProfilePage());
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Order History
          ListTile(
            leading: const Icon(Icons.history, color: Colors.deepOrange),
            title: const Text('Order History'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _navigate(context, const OrderHistoryPage());
            },
          ),
          const Divider(),

          // Addresses
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.deepOrange),
            title: const Text('Saved Addresses'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _navigate(context, const AddressesPage());
            },
          ),
          const Divider(),

          // Settings
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.deepOrange),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _navigate(context, const SettingsPage());
            },
          ),
          const Divider(),

          // Login/Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.deepOrange),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
