class AppSettings {
  bool notificationsEnabled;
  bool darkMode;

  AppSettings({required this.notificationsEnabled, required this.darkMode});

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        notificationsEnabled: json['notificationsEnabled'] ?? true,
        darkMode: json['darkMode'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'notificationsEnabled': notificationsEnabled,
        'darkMode': darkMode,
      };
}
