import 'package:flutter/material.dart';
import 'package:dnd_app/screens/screens.dart';
import 'package:dnd_app/providers/cards_provider.dart';
import 'package:provider/provider.dart';

/// Punto de entrada de la aplicación
void main() => runApp(AppState());

/// Widget que configura el estado global de la aplicación usando MultiProvider
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Configura los proveedores de estado
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardsProvider(), // Instancia el CardsProvider
          lazy: false, // Carga inmediatamente (no espera el primer uso)
        )
      ],
      child: MyApp(), // Widget principal de la app
    );
  }
}

/// Widget principal que configura la aplicación Material
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta "Debug"
      title: 'Hearthstone Cards', // Título de la app
      initialRoute: 'home', // Ruta inicial
      routes: {
        'home': (BuildContext context) => HomeScreen(), // Pantalla principal
        'details': (BuildContext context) => DetailsScreen(), // Pantalla de detalles
      },
      // Configuración del tema oscuro con AppBar transparente
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(0, 0, 0, 0)),
      ),
    );
  }
}
