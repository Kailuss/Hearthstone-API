import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:dnd_app/models/hs_card.dart';

/// Widget que muestra un carrusel interactivo de cartas Hearthstone
/// - Usa el paquete card_swiper para efectos visuales avanzados
/// - Incluye animaciones Hero para transiciones fluidas
class CardSwiper extends StatelessWidget {
  // Lista de cartas que se mostrarán en el swiper
  final List<HSCard> cards;

  // Constructor con parámetro requerido de cards
  const CardSwiper({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    // Obtiene las dimensiones de la pantalla para diseño responsive
    final size = MediaQuery.of(context).size;

    // Calcula las dimensiones del swiper según el tamaño de la pantalla
    final swiperHeight = size.height * 0.56; // 56% de la altura
    final cardWidth = size.width * 0.7; // 70% del ancho
    final cardHeight = size.height * 0.7; // 70% de la altura

    return Padding(
      padding: const EdgeInsets.only(left: 20), // Margen izquierdo para alineación visual
      child: SizedBox(
        width: double.infinity, // Ancho completo
        height: swiperHeight, // Altura calculada
        child: Swiper(
          itemCount: cards.length, // Número de cartas
          layout: SwiperLayout.STACK, // Efecto visual de apilamiento
          itemWidth: cardWidth, // Ancho de cada carta
          itemHeight: cardHeight, // Alto de cada carta
          itemBuilder: (BuildContext context, int index) {
            final card = cards[index];
            return GestureDetector(
              onTap: () => _navigateToDetails(context, card), // Navegación al hacer tap
              // Animación Hero para transición fluida entre pantallas
              child: Hero(
                tag: card.id, // Identificador único para la animación
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.png'), // Imagen de carga
                  image: NetworkImage(card.image), // Imagen desde la red
                  fit: BoxFit.contain, // Ajuste de imagen manteniendo proporciones
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  imageErrorBuilder: (context, error, stackTrace) => const Icon(Icons.error), // Manejo de errores
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Navega a la pantalla de detalles con la carta seleccionada
  void _navigateToDetails(BuildContext context, HSCard card) {
    Navigator.pushNamed(
      context,
      'details',
      arguments: card, // Pasa la carta como argumento
    );
  }
}
