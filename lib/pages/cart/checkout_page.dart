import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../utils/local_storage.dart';

class CheckoutPage extends StatefulWidget {
  final double total;
  final List<Map<String, dynamic>> items;
  const CheckoutPage({super.key, required this.total, required this.items});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String phone = '';
  bool isPlacingOrder = false;
  bool orderPlaced = false;

  Future<void> placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { isPlacingOrder = true; });
    await Future.delayed(const Duration(seconds: 2));
    // Save order to local storage
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now().toIso8601String().substring(0, 10),
      total: widget.total,
      status: 'Placed',
      items: widget.items,
    );
    final orders = await LocalStorage.loadOrders();
    orders.insert(0, order); // newest first
    await LocalStorage.saveOrders(orders);
    setState(() {
      isPlacingOrder = false;
      orderPlaced = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.deepOrange,
      ),
      body: orderPlaced
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 70),
                  const SizedBox(height: 18),
                  const Text('Order Placed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Thank you for ordering with JakeFoods!', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop('order_placed'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Delivery Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 18),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                      onChanged: (v) => name = v,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.length < 10 ? 'Enter a valid phone number' : null,
                      onChanged: (v) => phone = v,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
                      maxLines: 3,
                      validator: (value) => value == null || value.isEmpty ? 'Enter your address' : null,
                      onChanged: (v) => address = v,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 18)),
                        Text('₹${widget.total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isPlacingOrder ? null : placeOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        ),
                        child: isPlacingOrder
                            ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Place Order', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
