import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ArthakhabarApp());
}

class ArthakhabarApp extends StatelessWidget {
  const ArthakhabarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'अर्थ खबर',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
