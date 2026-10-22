import 'package:flutter/material.dart';
//import 'ui/screens/catalog_screen.dart';
import 'ui/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      //home: CatalogScreen(),
    );
  }
}