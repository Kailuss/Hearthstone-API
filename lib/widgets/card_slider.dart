import 'package:flutter/material.dart';
import 'package:dnd_app/models/hs_card.dart';

/// Widget que muestra una lista horizontal de cartas con un título
/// - Usado en la pantalla principal para mostrar secciones como "Raras" o "Cartas del mismo set"
class CardSlider extends StatelessWidget {
  final List<HSCard> cards; // Lista de cartas a mostrar
  final String title; // Título de la sección (ej: "Raras")

  const CardSlider({
    super.key,
    required this.cards,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ancho completo
      height: 270, // Altura fija del contenedor
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación izquierda
        children: [
          // Título de la sección
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5), // Espaciado

          // Lista horizontal de cartas
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal
              itemCount: cards.length,
              itemBuilder: (_, int index) => _CreaturePortrait(card: cards[index]),
            ),
          )
        ],
      ),
    );
  }
}

/// Widget que representa el retrato de una carta individual en la lista
class _CreaturePortrait extends StatelessWidget {
  final HSCard card;

  const _CreaturePortrait({
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Ancho fijo para cada carta
      height: 120, // Altura fija
      margin: const EdgeInsets.symmetric(horizontal: 2), // Margen entre cartas
      child: Column(
        children: [
          // Imagen de la carta (tappable)
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: card),
            child: Hero(
              tag: '${card.id}-list', // Identificador único para la animación Hero
              child: ClipRRect(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.png'), // Imagen de carga
                  image: NetworkImage(card.image), // Imagen desde la red
                  width: 100,
                  height: 120,
                  fit: BoxFit.contain, // Ajuste de imagen
                  imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          // Nombre de la carta (2 líneas máximo)
          Text(
            card.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // "..." si el texto es muy largo
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          )
        ],
      ),
    );
  }
}
