import 'package:flutter/material.dart';
import '../models/hs_card.dart';

/// Widget que muestra una lista horizontal de cartas pertenecientes a un set/expansión específico
class SetCards extends StatelessWidget {
  final List<HSCard> setCards; // Lista de cartas del set

  const SetCards({super.key, required this.setCards});

  @override
  Widget build(BuildContext context) {
    // Si no hay cartas, retorna un widget vacío (evita mostrar espacio innecesario)
    if (setCards.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 30), // Margen inferior
      width: double.infinity, // Ancho completo
      height: 200, // Altura fija del contenedor
      child: ListView.builder(
        itemCount: setCards.length, // Número de cartas
        scrollDirection: Axis.horizontal, // Scroll horizontal
        itemBuilder: (BuildContext context, int index) => _SetCard(card: setCards[index]),
      ),
    );
  }
}

/// Widget que representa una carta individual dentro del set
class _SetCard extends StatelessWidget {
  final HSCard card;
  const _SetCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2), // Margen entre cartas
      width: 110, // Ancho fijo por carta
      height: 100, // Altura fija
      child: Column(
        children: [
          // Imagen de la carta con placeholder
          ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.png'), // Imagen de carga
              image: NetworkImage(card.image), // Imagen real
              height: 140,
              width: 100,
              fit: BoxFit.contain, // Mantiene proporciones
            ),
          ),
          // Nombre de la carta (2 líneas máximo)
          Text(
            card.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Muestra "..." si el texto es largo
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
