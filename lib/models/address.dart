class Address {
  String label;
  String details;

  Address({required this.label, required this.details});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        label: json['label'] ?? '',
        details: json['details'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'details': details,
      };
}
