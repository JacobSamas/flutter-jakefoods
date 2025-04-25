import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../utils/local_storage.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Order> _orders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final orders = await LocalStorage.loadOrders();
    setState(() {
      _orders = orders;
      _orders.sort((a, b) => b.date.compareTo(a.date)); // sort orders by date in descending order
      _loading = false;
    });
  }

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${order.date}'),
            Text('Status: ${order.status}'),
            const Divider(),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(item['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w500))),
                  Text('x${item['quantity']}'),
                  Text('₹${item['price']}'),
                ],
              ),
            )),
            const Divider(),
            Text('Total: ₹${order.total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _orders.isEmpty
          ? const Center(child: Text('No orders yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount: _orders.length,
              separatorBuilder: (context, i) => const Divider(),
              itemBuilder: (context, i) {
                final order = _orders[i];
                return ListTile(
                  leading: CircleAvatar(child: Text(order.id.substring(order.id.length - 2))),
                  title: Text('Order #${order.id}'),
                  subtitle: Text('${order.date} • ${order.status}'),
                  trailing: Text('₹${order.total.toStringAsFixed(0)}'),
                  onTap: () => _showOrderDetails(order),
                );
              },
            ),
    );
  }
}
