import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'components/main_navigation.dart';

class JakeFoodsApp extends StatelessWidget {
  const JakeFoodsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JakeFoods',
      theme: JakeFoodsTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainNavigation(),
    );
  }
}
