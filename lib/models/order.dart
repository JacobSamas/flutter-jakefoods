class Order {
  String id;
  String date;
  double total;
  String status;
  List<Map<String, dynamic>> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        date: json['date'],
        total: (json['total'] as num).toDouble(),
        status: json['status'],
        items: List<Map<String, dynamic>>.from(json['items'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'total': total,
        'status': status,
        'items': items,
      };
}
