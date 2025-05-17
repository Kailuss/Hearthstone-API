import 'dart:ui';
import 'package:dnd_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:dnd_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/cards_provider.dart';

/// Pantalla que muestra los detalles de una carta específica y cartas relacionadas de su set.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Carga cartas del mismo set después de que el widget se construye
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final HSCard card = ModalRoute.of(context)!.settings.arguments as HSCard;
      final cardsProvider = Provider.of<CardsProvider>(context, listen: false);
      cardsProvider.getSetCards(card.cardSetId); // Carga cartas del mismo set
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardsProvider>(context, listen: true);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(), // AppBar personalizado con imagen de fondo
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _CardAndStats(), // Imagen de la carta + estadísticas
                _Overview(), // Descripción/texto de la carta
                SetCards(setCards: cardsProvider.onSetCards), // Lista de cartas del mismo set
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// AppBar personalizado con efecto de imagen difuminada y título superpuesto.
class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HSCard card = ModalRoute.of(context)?.settings.arguments as HSCard;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 160,
      floating: false,
      pinned: true, // Permite que el AppBar permanezca visible al hacer scroll
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Título de la carta (centrado)
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                card.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(offset: Offset(0.0, 1.0), blurRadius: 5.0, color: Colors.black)],
                ),
              ),
            ),
            // Texto 'flavor' (descripción corta)
            Container(
              padding: const EdgeInsets.only(top: 2, left: 32, right: 32, bottom: 8),
              child: Text(
                card.flavorText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  shadows: [Shadow(offset: Offset(0.0, 1.5), blurRadius: 3.0, color: Colors.black)],
                ),
              ),
            ),
          ],
        ),
        // Fondo con imagen recortada y efecto blur
        background: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/loading.gif'), // Placeholder durante carga
              image: NetworkImage(card.cropImage),
              fit: BoxFit.cover,
            ),
            // Efecto de difuminado
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(color: const Color.fromARGB(111, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Muestra la imagen de la carta junto a sus estadísticas principales.
class _CardAndStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HSCard card = ModalRoute.of(context)?.settings.arguments as HSCard;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagen de la carta (con placeholder de carga)
          ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(card.image),
              height: 200,
            ),
          ),
          const SizedBox(width: 10),
          // Estadísticas (salud, ataque, maná)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(card.name, style: textTheme.titleMedium),
              Text('Ilustración: ${card.artistName}', style: textTheme.titleSmall),
              const SizedBox(height: 30),
              // Fila de íconos: Salud y Ataque
              Row(
                children: [
                  const Icon(Icons.water_drop, size: 16, color: Color.fromARGB(255, 170, 32, 32)),
                  const SizedBox(width: 3),
                  Text('Salud: ${card.health ?? 'N/A'}', style: textTheme.bodySmall),
                  const SizedBox(width: 16),
                  const Icon(Icons.bolt, size: 18, color: Color.fromARGB(255, 255, 199, 15)),
                  Text('Ataque: ${card.attack ?? 'N/A'}', style: textTheme.bodySmall),
                ],
              ),
              // Fila de ícono: Coste de maná
              Row(
                children: [
                  const Icon(Icons.diamond, size: 16, color: Color.fromARGB(255, 14, 122, 205)),
                  const SizedBox(width: 3),
                  Text('Coste de maná: ${card.manaCost}', style: textTheme.bodySmall),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// Muestra el texto descriptivo de la carta (habilidades/efectos).
class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HSCard card = ModalRoute.of(context)?.settings.arguments as HSCard;
    return Container(
      padding: const EdgeInsets.only(left: 48, right: 48, top: 8, bottom: 32),
      child: Text(
        card.text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
