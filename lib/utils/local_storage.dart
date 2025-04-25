import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/address.dart';
import '../models/order.dart';
import '../models/settings.dart';

class LocalStorage {
  static Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_profile', jsonEncode(profile.toJson()));
  }

  static Future<UserProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('user_profile');
    if (str == null) {
      return UserProfile(name: 'Jake', email: 'jake@email.com', phone: '', avatarPath: null);
    }
    return UserProfile.fromJson(jsonDecode(str));
  }

  static Future<void> saveAddresses(List<Address> addresses) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('addresses', jsonEncode(addresses.map((a) => a.toJson()).toList()));
  }

  static Future<List<Address>> loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('addresses');
    if (str == null) return [];
    final list = jsonDecode(str) as List;
    return list.map((a) => Address.fromJson(a)).toList();
  }

  static Future<void> saveOrders(List<Order> orders) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('orders', jsonEncode(orders.map((o) => o.toJson()).toList()));
  }

  static Future<List<Order>> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('orders');
    if (str == null) return [];
    final list = jsonDecode(str) as List;
    return list.map((o) => Order.fromJson(o)).toList();
  }

  static Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('settings', jsonEncode(settings.toJson()));
  }

  static Future<AppSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('settings');
    if (str == null) return AppSettings(notificationsEnabled: true, darkMode: false);
    return AppSettings.fromJson(jsonDecode(str));
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
