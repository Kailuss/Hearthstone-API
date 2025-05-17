import 'package:dnd_app/providers/cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:dnd_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

/// Pantalla principal que muestra:
/// - Un AppBar con el logo de Hearthstone
/// - Un carrusel de cartas (CardSwiper)
/// - Una lista horizontal de cartas "raras" (CardSlider)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el proveedor de cartas (escucha cambios con listen: true)
    final cardProvider = Provider.of<CardsProvider>(context, listen: true);

    return Scaffold(
      // AppBar personalizado con logo
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Altura fija
        child: AppBar(
          backgroundColor: Colors.transparent, // Fondo transparente
          flexibleSpace: Container(
            margin: const EdgeInsets.only(top: 20), // Margen superior
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/hearthstone_logo.png'), // Logo desde assets
                fit: BoxFit.contain, // Ajusta la imagen sin recortar
              ),
            ),
          ),
        ),
      ),
      // Cuerpo desplazable
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrusel de cartas principales
            CardSwiper(cards: cardProvider.onDisplayCards),

            // Lista horizontal de cartas "raras"
            CardSlider(
              cards: cardProvider.onDisplayCards,
              title: 'Raras', // Título de la sección
            ),
          ],
        ),
      ),
    );
  }
}
