import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CertPrepApp());
}

class CertPrepApp extends StatelessWidget {
  const CertPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cert Prep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}