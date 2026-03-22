import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const EdidactApp());
}

class EdidactApp extends StatelessWidget {
  const EdidactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edidact',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C3D0),
        ),
      ),
      home:  const HomePage(),
    );
  }
}