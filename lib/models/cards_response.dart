import 'dart:convert'; // Para trabajar con JSON
import 'package:dnd_app/models/hs_card.dart'; // Modelo de carta (HSCard)

// Clase que representa una respuesta de la API con una lista de cartas
class CardsResponse {
  final List<HSCard> cards; // Lista de cartas (objetos HSCard)
  final int cardCount; // Cantidad total de cartas disponibles
  final int pageCount; // Número total de páginas disponibles
  final int page; // Página actual de la respuesta

  // Constructor principal
  CardsResponse({
    required this.cards,
    required this.cardCount,
    required this.pageCount,
    required this.page,
  });

  // Constructor factory para crear una instancia de CardsResponse desde un JSON
  factory CardsResponse.fromJson(String str) {
    // Decodifica el JSON (String) a un Map<String, dynamic>
    final Map<String, dynamic> jsonData = json.decode(str);

    // Retorna una nueva instancia de CardsResponse con los datos del JSON
    return CardsResponse(
      // Convierte cada elemento de la lista 'cards' en un objeto HSCard usando HSCard.fromMap
      cards: List<HSCard>.from(jsonData['cards'].map((card) => HSCard.fromMap(card))),
      cardCount: jsonData['cardCount'], // Obtiene el número total de cartas
      pageCount: jsonData['pageCount'], // Obtiene el número total de páginas
      page: jsonData['page'], // Obtiene la página actual
    );
  }
}
