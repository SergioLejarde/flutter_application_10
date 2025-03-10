import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Browntastic App',
      home: LoginScreen(),
      routes: {
        "/home": (context) => Scaffold(body: Center(child: Text("Pantalla Principal"))), // Temporalmente
      },
    );
  }
}
