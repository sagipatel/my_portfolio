// lib/main.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/portfolio_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dev Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const PortfolioScreen(),
      scrollBehavior: _WebScrollBehavior(),
    );
  }
}

// Enables mouse drag scrolling on web
class _WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}


