# JakeFoods

JakeFoods is a modern Flutter-based food delivery app inspired by Swiggy and Zomato. It demonstrates a beautiful UI, clean architecture, and Dart best practices for scalable mobile development.

## Features
- **Home Page**: Modern landing screen with search, categories, and popular dishes (with add-to-cart)
- **Restaurant Listing & Details**: Demo structure for restaurant browsing
- **Cart**: Add/remove items, quantity management, checkout flow with persistent order history
- **Profile Section**: Edit profile, view order history, manage addresses, settings, and logout
- **Persistent Storage**: User profile, addresses, orders, and settings are saved locally using `shared_preferences`
- **Image Picker**: Update profile avatar from gallery
- **Modern UI/UX**: Deep orange theme, responsive layouts, and mobile-friendly components

## Getting Started
1. **Install Flutter**: https://flutter.dev/docs/get-started/install
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   - Android: `flutter run`
   - iOS: `flutter run`

## File Structure
```
lib/
  main.dart
  app.dart
  pages/
    home/
      home_page.dart
    cart/
      cart_page.dart
      checkout_page.dart
    profile/
      profile_page.dart
      edit_profile_page.dart
      order_history_page.dart
      addresses_page.dart
      settings_page.dart
      login_page.dart
    restaurant/
      restaurant_list_page.dart
  components/
    main_navigation.dart
  models/
    user_profile.dart
    order.dart
    address.dart
    settings.dart
  utils/
    local_storage.dart
  theme/
assets/
  images/
  icons/
```

## Demo Data
- The app uses demo data for dishes, categories, and restaurants.
- All data is persisted locally; there is no backend or real API.

## Known Issues
- Some demo images are loaded from Unsplash and may break if URLs change.
- Cart state is local to HomePage; to make it global, consider using Provider or Riverpod.
- UI is optimized for mobile, not web or tablet.

## License
MIT License. Use and modify freely for learning or demo purposes.

---

**JakeFoods** is a frontend showcase. For backend/API integration, you can extend the models and storage utilities.
