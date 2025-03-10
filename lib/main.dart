import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';  // Para móvil/escritorio
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // Para Web

import 'providers/favorites_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/articles_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Configurar SQLite correctamente según la plataforma
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb; // Para Web
  } else {
    sqfliteFfiInit(); // Para Móvil/Escritorio
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Browntastic App',
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginScreen(),
        "/home": (context) => const HomeScreen(),
        "/articles": (context) => const ArticlesScreen(),
      },
    );
  }
}
