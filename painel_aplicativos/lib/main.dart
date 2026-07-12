import 'package:flutter/material.dart';

import 'screens/cadastro_screen.dart';
import 'screens/details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const PainelAplicativosApp());
}

class PainelAplicativosApp extends StatelessWidget {
  const PainelAplicativosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Painel de Aplicativos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/detalhes': (context) => const DetailsScreen(),
        '/cadastro': (context) => const CadastroScreen(),
      },
    );
  }
}
